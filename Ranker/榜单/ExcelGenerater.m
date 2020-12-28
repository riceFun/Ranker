//
//  ExcelGenerater.m
//  Ranker
//
//  Created by riceFun on 2020/11/6.
//

#import "ExcelGenerater.h"
#import <xlsxwriter/xlsxwriter.h>//这个是写 还有读是这个库 DHlibxls  暂时没有试过

#import "RankDataCenter.h"
#import "RankBigModel.h"

@interface ExcelGenerater()
@property (nonatomic,copy) NSString *filePath;
@property (nonatomic,copy) NSString *fileName;

//记录已经被记录在excel上的账号，如果有的话，直接记录其值，不再记录账号名字和头像地址
@property (nonatomic,copy) NSMutableDictionary *mDic_accout;

@end

@implementation ExcelGenerater

+ (ExcelGenerater *)sharedInstance {
    static ExcelGenerater *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ExcelGenerater alloc]init];
    });
    return instance;
}

//取前几的数据生成excel
- (void)generateWithDataArray:(NSArray *)dataArray top:(int)top  {
    dataArray = [RankDataCenter sortWithDataArray:dataArray top:top];
    [self generateWithArray:dataArray];
}

//直接生成excel
- (void)generateWithArray:(NSArray *)dataArray {
    if (dataArray.count == 0) {
        NSLog(@"本地数据为空，请先下载");
        return;
    }
    
    //2.创建表格workbook，和工作表worksheet：
    lxw_workbook  *workbook  = workbook_new([self.fileName UTF8String]);
    // 创建sheet
    lxw_worksheet *worksheet = workbook_add_worksheet(workbook, NULL);
    
    //3.插入数据
    //3.1 (1,1) 姓名 # (1,2) 头像 # 之后全部是日期
    worksheet_write_string(worksheet, 0, 0, "账号姓名", NULL);
    worksheet_write_string(worksheet, 0, 1, "头像", NULL);
    
    //3.2 插入具体数据 x 代表行  y 代表列
    //3.2.1 先遍历最外层的 bigmodel，插入日期
    int x = 0;
    for (int y = 0; y < dataArray.count; y++) {
        RankBigModel *bigModel = dataArray[y];
        //插入日期，在第一行，列数的数每次加2，因为前面有两个(账号姓名、头像)
        worksheet_write_number(worksheet, 0, y+2,[bigModel.updated doubleValue], NULL);
        
        //3.2.2 遍历bigModel内部的model，插入具体数据
        for (int i = 0; i < bigModel.list.count; i++) {
            RankModel *model = bigModel.list[i];
            //没有这个账号
            if (self.mDic_accout[model.author_id] == nil) {
                //没有这个就要加一行，加到最后面
                x++;
                
                //那就存这个 author_id 及 账号所在的行x
                self.mDic_accout[model.author_id] = [NSNumber numberWithInt:x];

                //插入账号名字
                worksheet_write_string(worksheet, x, 0, (char*) [model.name UTF8String], NULL);
                //插入账号头像
                worksheet_write_string(worksheet, x, 1, (char*) [model.avatar UTF8String], NULL);

                //插入日期所对应的值
                worksheet_write_number(worksheet, x, y+2,[model.fans doubleValue], NULL);
            } else {
                //有这个账号，拿到对应的行，插入值 转成 int值
                int pX = [self.mDic_accout[model.author_id] intValue];
                //插入日期所对应的值
                worksheet_write_number(worksheet, pX, y+2,[model.fans doubleValue], NULL);
            }
        }
    }
    
    //4.保存生成的文件
    workbook_close(workbook);
    NSLog(@"file path: %@",self.filePath);
}


#pragma mark lazyLoad
- (NSString *)filePath {
    if (!_filePath) {
        // 文件保存的路径
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        _filePath = documentPath;
    }
    return _filePath;
}

- (NSString *)fileName {
    if (!_fileName) {
        _fileName = [self.filePath stringByAppendingPathComponent:@"c_demo.xlsx"];
    }
    return _fileName;
}


- (NSMutableDictionary *)mDic_accout {
    if (!_mDic_accout) {
        _mDic_accout = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    return _mDic_accout;;
}


@end
