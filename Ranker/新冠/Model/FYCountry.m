//
//  FYCountry.m
//  Ranker
//
//  Created by riceFun on 2020/11/11.
//

#import "FYCountry.h"

@implementation FYCountry

- (void)setISO2:(NSString *)ISO2 {
    _ISO2 = ISO2;
    _Flag = [NSString stringWithFormat:@"https://www.countryflags.io/%@/flat/64.png",ISO2];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_Country forKey:@"Country"];
    [coder encodeObject:_Slug forKey:@"Slug"];
    [coder encodeObject:_ISO2 forKey:@"ISO2"];
    [coder encodeObject:_Flag forKey:@"Flag"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _Country = [coder decodeObjectForKey:@"Country"];
        _Slug = [coder decodeObjectForKey:@"Slug"];
        _ISO2 = [coder decodeObjectForKey:@"ISO2"];
        _Flag = [coder decodeObjectForKey:@"Flag"];
    }
    return self;
}


@end

@implementation FYCountryOtherData
+ (NSDictionary *)getCountryOtherData {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    NSArray *dataArra = [FYCountryOtherData dataArray];
    for (NSString *data in dataArra) {
        NSArray *subArray = [data componentsSeparatedByString:@"------"];
        FYCountryOtherData *OtherData = [[FYCountryOtherData alloc] init];
//        codeP.continent = continent;
        OtherData.name_chinese = subArray[0];
        OtherData.name_english = subArray[1];
        OtherData.code = subArray[2];
        
        mDic[subArray[2]] = OtherData;
    }
    return [mDic copy];
    NSLog(@"jjjj");
}

+ (NSArray *)dataArray {
   return  @[
       @"阿富汗------Afghanistan------AF",
       @"奥兰群岛------Aland Islands------AX",
       @"阿尔巴尼亚------Albania------AL",
       @"阿尔及利亚------Algeria------DZ",
       @"美属萨摩亚------American Samoa------AS",
       @"安道尔------Andorra------AD",
       @"安哥拉------Angola------AO",
       @"安圭拉------Anguilla------AI",
       @"南极洲------Antarctica------AQ",
       @"安提瓜和巴布达------Antigua and Barbuda------AG",
       @"阿根廷------Argentina------AR",
       @"亚美尼亚------Armenia------AM",
       @"阿鲁巴------Aruba------AW",
       @"澳大利亚------Australia------AU",
       @"奥地利------Austria------AT",
       @"阿塞拜疆------Azerbaijan------AZ",
       @"巴哈马------Bahamas (The)------BS",
       @"巴林------Bahrain------BH",
       @"孟加拉国------Bangladesh------BD",
       @"巴巴多斯------Barbados------BB",
       @"白俄罗斯------Belarus------BY",
       @"比利时------Belgium------BE",
       @"伯利兹------Belize------BZ",
       @"贝宁------Benin------BJ",
       @"百慕大------Bermuda------BM",
       @"不丹------Bhutan------BT",
       @"玻利维亚------Bolivia------BO",
       @"波黑------Bosnia and Herzegovina------BA",
       @"博茨瓦纳------Botswana------BW",
       @"布维岛------Bouvet Island------BV",
       @"巴西------Brazil------BR",
       @"英属印度洋领地------British Indian Ocean Territory (the)------IO",
       @"文莱------Brunei Darussalam------BN",
       @"保加利亚------Bulgaria------BG",
       @"布基纳法索------Burkina Faso------BF",
       @"布隆迪------Burundi------BI",
       @"柬埔寨------Cambodia------KH",
       @"喀麦隆------Cameroon------CM",
       @"加拿大------Canada------CA",
       @"佛得角------Cape Verde------CV",
       @"开曼群岛------Cayman Islands (the)------KY",
       @"中非------Central African Republic (the)------CF",
       @"乍得------Chad------TD",
       @"智利------Chile------CL",
       @"中国------China------CN",
       @"圣诞岛------Christmas Island------CX",
       @"科科斯（基林）群岛------Cocos (Keeling) Islands (the)------CC",
       @"哥伦比亚------Colombia------CO",
       @"科摩罗------Comoros------KM",
       @"刚果（布）------Congo------CG",
       @"刚果（金）------Congo (the Democratic Republic of the)------CD",
       @"库克群岛------Cook Islands (the)------CK",
       @"哥斯达黎加------Costa Rica------CR",
       @"科特迪瓦------Côte d'Ivoire------CI",
       @"克罗地亚------Croatia------HR",
       @"古巴------Cuba------CU",
       @"塞浦路斯------Cyprus------CY",
       @"捷克------Czech Republic (the)------CZ",
       @"丹麦------Denmark------DK",
       @"吉布提------Djibouti------DJ",
       @"多米尼克------Dominica------DM",
       @"多米尼加------Dominican Republic (the)------DO",
       @"厄瓜多尔------Ecuador------EC",
       @"埃及------Egypt------EG",
       @"萨尔瓦多------El Salvador------SV",
       @"赤道几内亚------Equatorial Guinea------GQ",
       @"厄立特里亚------Eritrea------ER",
       @"爱沙尼亚------Estonia------EE",
       @"埃塞俄比亚------Ethiopia------ET",
       @"福克兰群岛（马尔维纳斯）------Falkland Islands (the) [Malvinas]------FK",
       @"法罗群岛------Faroe Islands (the)------FO",
       @"斐济------Fiji------FJ",
       @"芬兰------Finland------FI",
       @"法国------France------FR",
       @"法属圭亚那------French Guiana------GF",
       @"法属波利尼西亚------French Polynesia------PF",
       @"法属南部领地------French Southern Territories (the)------TF",
       @"加蓬------Gabon------GA",
       @"冈比亚------Gambia (The)------GM",
       @"格鲁吉亚------Georgia------GE",
       @"德国------Germany------DE",
       @"加纳------Ghana------GH",
       @"直布罗陀------Gibraltar------GI",
       @"希腊------Greece------GR",
       @"格陵兰------Greenland------GL",
       @"格林纳达------Grenada------GD",
       @"瓜德罗普------Guadeloupe------GP",
       @"关岛------Guam------GU",
       @"危地马拉------Guatemala------GT",
       @"格恩西岛------Guernsey------GG",
       @"几内亚------Guinea------GN",
       @"几内亚比绍------Guinea-Bissau------GW",
       @"圭亚那------Guyana------GY",
       @"海地------Haiti------HT",
       @"赫德岛和麦克唐纳岛------Heard Island and McDonald Islands------HM",
       @"梵蒂冈------Holy See (the) [Vatican City State]------VA",
       @"洪都拉斯------Honduras------HN",
       @"香港------Hong Kong------HK",
       @"匈牙利------Hungary------HU",
       @"冰岛------Iceland------IS",
       @"印度------India------IN",
       @"印度尼西亚------Indonesia------ID",
       @"伊朗------Iran (the Islamic Republic of)------IR",
       @"伊拉克------Iraq------IQ",
       @"爱尔兰------Ireland------IE",
       @"英国属地曼岛------Isle of Man------IM",
       @"以色列------Israel------IL",
       @"意大利------Italy------IT",
       @"牙买加------Jamaica------JM",
       @"日本------Japan------JP",
       @"泽西岛------Jersey------JE",
       @"约旦------Jordan------JO",
       @"哈萨克斯坦------Kazakhstan------KZ",
       @"肯尼亚------Kenya------KE",
       @"基里巴斯------Kiribati------KI",
       @"朝鲜------Korea (the Democratic People's Republic of)------KP",
       @"韩国------Korea (the Republic of)------KR",
       @"科威特------Kuwait------KW",
       @"吉尔吉斯斯坦------Kyrgyzstan------KG",
       @"老挝------Lao People's Democratic Republic (the)------LA",
       @"拉脱维亚------Latvia------LV",
       @"黎巴嫩------Lebanon------LB",
       @"莱索托------Lesotho------LS",
       @"利比里亚------Liberia------LR",
       @"利比亚------Libyan Arab Jamahiriya (the)------LY",
       @"列支敦士登------Liechtenstein------LI",
       @"立陶宛------Lithuania------LT",
       @"卢森堡------Luxembourg------LU",
       @"澳门------Macao------MO",
       @"前南马其顿------Macedonia (the former Yugoslav Republic of)------MK",
       @"马达加斯加------Madagascar------MG",
       @"马拉维------Malawi------MW",
       @"马来西亚------Malaysia------MY",
       @"马尔代夫------Maldives------MV",
       @"马里------Mali------ML",
       @"马耳他------Malta------MT",
       @"马绍尔群岛------Marshall Islands (the)------MH",
       @"马提尼克------Martinique------MQ",
       @"毛利塔尼亚------Mauritania------MR",
       @"毛里求斯------Mauritius------MU",
       @"马约特------Mayotte------YT",
       @"墨西哥------Mexico------MX",
       @"密克罗尼西亚联邦------Micronesia (the Federated States of)------FM",
       @"摩尔多瓦------Moldova (the Republic of)------MD",
       @"摩纳哥------Monaco------MC",
       @"蒙古------Mongolia------MN",
       @"黑山------Montenegro------ME",
       @"蒙特塞拉特------Montserrat------MS",
       @"摩洛哥------Morocco------MA",
       @"莫桑比克------Mozambique------MZ",
       @"缅甸------Myanmar------MM",
       @"纳米比亚------Namibia------NA",
       @"瑙鲁------Nauru------NR",
       @"尼泊尔------Nepal------NP",
       @"荷兰------Netherlands (the)------NL",
       @"荷属安的列斯------Netherlands Antilles (the)------AN",
       @"新喀里多尼亚------New Caledonia------NC",
       @"新西兰------New Zealand------NZ",
       @"尼加拉瓜------Nicaragua------NI",
       @"尼日尔------Niger (the)------NE",
       @"尼日利亚------Nigeria------NG",
       @"纽埃------Niue------NU",
       @"诺福克岛------Norfolk Island------NF",
       @"北马里亚纳------Northern Mariana Islands (the)------MP",
       @"挪威------Norway------NO",
       @"阿曼------Oman------OM",
       @"巴基斯坦------Pakistan------PK",
       @"帕劳------Palau------PW",
       @"巴勒斯坦------Palestinian Territory (the Occupied)------PS",
       @"巴拿马------Panama------PA",
       @"巴布亚新几内亚------Papua New Guinea------PG",
       @"巴拉圭------Paraguay------PY",
       @"秘鲁------Peru------PE",
       @"菲律宾------Philippines (the)------PH",
       @"皮特凯恩------Pitcairn------PN",
       @"波兰------Poland------PL",
       @"葡萄牙------Portugal------PT",
       @"波多黎各------Puerto Rico------PR",
       @"卡塔尔------Qatar------QA",
       @"留尼汪------Réunion------RE",
       @"罗马尼亚------Romania------RO",
       @"俄罗斯联邦------Russian Federation (the)------RU",
       @"卢旺达------Rwanda------RW",
       @"圣赫勒拿------Saint Helena------SH",
       @"圣基茨和尼维斯------Saint Kitts and Nevis------KN",
       @"圣卢西亚------Saint Lucia------LC",
       @"圣皮埃尔和密克隆------Saint Pierre and Miquelon------PM",
       @"圣文森特和格林纳丁斯------Saint Vincent and the Grenadines------VC",
       @"萨摩亚------Samoa------WS",
       @"圣马力诺------San Marino------SM",
       @"圣多美和普林西比------Sao Tome and Principe------ST",
       @"沙特阿拉伯------Saudi Arabia------SA",
       @"塞内加尔------Senegal------SN",
       @"塞尔维亚------Serbia------RS",
       @"塞舌尔------Seychelles------SC",
       @"塞拉利昂------Sierra Leone------SL",
       @"新加坡------Singapore------SG",
       @"斯洛伐克------Slovakia------SK",
       @"斯洛文尼亚------Slovenia------SI",
       @"所罗门群岛------Solomon Islands (the)------SB",
       @"索马里------Somalia------SO",
       @"南非------South Africa------ZA",
       @"南乔治亚岛和南桑德韦奇岛------South Georgia and the South Sandwich Islands------GS",
       @"西班牙------Spain------ES",
       @"斯里兰卡------Sri Lanka------LK",
       @"苏丹------Sudan (the)------SD",
       @"苏里南------Suriname------SR",
       @"斯瓦尔巴岛和扬马延岛------Svalbard and Jan Mayen------SJ",
       @"斯威士兰------Swaziland------SZ",
       @"瑞典------Sweden------SE",
       @"瑞士------Switzerland------CH",
       @"叙利亚------Syrian Arab Republic (the)------SY",
       @"台湾------Taiwan (Province of China)------TW",
       @"塔吉克斯坦------Tajikistan------TJ",
       @"坦桑尼亚------Tanzania,United Republic of------TZ",
       @"泰国------Thailand------TH",
       @"东帝汶------Timor-Leste------TL",
       @"多哥------Togo------TG",
       @"托克劳------Tokelau------TK",
       @"汤加------Tonga------TO",
       @"特立尼达和多巴哥------Trinidad and Tobago------TT",
       @"突尼斯------Tunisia------TN",
       @"土耳其------Turkey------TR",
       @"土库曼斯坦------Turkmenistan------TM",
       @"特克斯和凯科斯群岛------Turks and Caicos Islands (the)------TC",
       @"图瓦卢------Tuvalu------TV",
       @"乌干达------Uganda------UG",
       @"乌克兰------Ukraine------UA",
       @"阿联酋------United Arab Emirates (the)------AE",
       @"英国------United Kingdom (the)------GB",
       @"美国------United States (the)------US",
       @"美国本土外小岛屿------United States Minor Outlying Islands (the)------UM",
       @"乌拉圭------Uruguay------UY",
       @"乌兹别克斯坦------Uzbekistan------UZ",
       @"瓦努阿图------Vanuatu------VU",
       @"委内瑞拉------Venezuela------VE",
       @"越南------Viet Nam------VN",
       @"英属维尔京群岛------Virgin Islands (British)------VG",
       @"美属维尔京群岛------Virgin Islands (U.S.)------VI",
       @"瓦利斯和富图纳------Wallis and Futuna------WF",
       @"西撒哈拉------Western Sahara------EH",
       @"也门------Yemen------YE",
       @"赞比亚------Zambia------ZM",
       @"津巴布韦------Zimbabwe------ZW",
       @"法属圣巴托洛缪岛------Saint-Barthélemy------BL",
       @"南苏丹------South Sudan------SS",
       @"科索沃------Republic of Kosovo------XK",
       @"法属圣马丁------Saint-Martin (French part)------XK",
   ];
}

@end

