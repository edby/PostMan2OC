//
//  ViewController.m
//  PostMan2OC
//
//  Created by pro on 2018/5/25.
//  Copyright © 2018年 Sat. All rights reserved.
//

#import "ViewController.h"
#import "Modles/PostManDataModels.h"
#define kRGBA(x,G,B,A) @{@"one":x,@"c_no":G,@"cuinfo_id":B,@"operFlag":A};


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    NSString *jsonPath = [mainBundle pathForResource:@"postMan" ofType:@"json"];
    NSString * jsonStr =[NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    
    
    NSDictionary * dic =  [self dictionaryWithJsonString:jsonStr];
    
    PostManPostMan * postMan  =[PostManPostMan modelObjectWithDictionary:dic];
    
    NSMutableString * txtStr =[NSMutableString string];

    
    for (PostManItem * postItem in postMan.item) {
        
        [txtStr appendString:[NSString stringWithFormat:@"\n\/\/--------------%@-----------\n\n",postItem.name]];
        
        
        for (NSDictionary * postItemDic  in postItem.item) {
            PostManItem *  postItemSub  =[PostManItem modelObjectWithDictionary:postItemDic];
            
            //            //分类名称
            [txtStr appendString:[NSString stringWithFormat:@"/*\n--------------%@-----------\n\n",postItemSub.name]];
            [txtStr appendString:[NSString stringWithFormat:@"*/\n"]];
            NSMutableString * discStr =[NSMutableString string];
            NSMutableString * defineStr =[NSMutableString string];
            NSMutableString * postStr =[NSMutableString string];
//            NSMutableString * keyStr =[NSMutableString string];
            NSMutableString * defineName =[NSMutableString string];
            
            //参数描述
            
            [defineStr appendString:[NSString stringWithFormat:@"@\{"]]; //@{
            for (PostManQuery *postManQuery in postItemSub.request.url.query) {
                
                [discStr appendString:[NSString stringWithFormat:@"\n* 参数:%@ 描述：%@",postManQuery.key,postManQuery.desc]];
                //                #define kRGBA(R,G,B,A) @{@"one":R,@"c_no":G,@"cuinfo_id":B,@"operFlag":A};
                
                //如果字典里是空则用key
                if (postManQuery.desc ==nil|| [postManQuery.desc isEqualToString:@""] ) {
                    
                    
                    [defineStr appendString:[NSString stringWithFormat:@"@\"%@\":%@,",postManQuery.key,postManQuery.key]];// @"one":R,
                    
                    [postStr appendString:[NSString stringWithFormat:@"%@,",postManQuery.key]]; //(R,G,B,A)
                    
                }else
                {
                    [defineStr appendString:[NSString stringWithFormat:@"@\"%@\":%@,",postManQuery.key,postManQuery.desc]];// @"one":R,
                    
                    [postStr appendString:[NSString stringWithFormat:@"%@,",postManQuery.desc]]; //(R,G,B,A)
                }

            }
            
#pragma mark   描述文件 内部过滤
            
    
//            defineStr =[self removeOtherStr:defineStr];
            postStr = [self removeLastStr:postStr]; //删除顿号
            postStr = [self removeOtherStr:postStr];
            
            [postStr insertString:@"(" atIndex:0];//添加括号
            [postStr insertString:@")" atIndex:postStr.length];//添加括号

            //宏名称
            
            for (NSString *postManPath in postItemSub.request.url.path) {
                
                
                [defineName appendString:[NSString stringWithFormat:@"%@",[postManPath capitalizedString]]];
                
                
            }
            
            
 #pragma mark   宏名称 内部过滤
            //宏名称 处理下划线
            defineName =[self removeOtherStr:defineName];
            defineStr =[self removeLastStr:defineStr];
            defineStr =[self removeOtherStr:defineStr];

            
            [defineStr appendString:[NSString stringWithFormat:@"}"]]; //}
            
 #pragma mark   参数 内部过滤
            
            
             postStr = [[postStr stringByReplacingOccurrencesOfString:@"." withString:@""] mutableCopy];
            //            请求地址 根据问好分割
            NSMutableString * finalUrl =[NSMutableString stringWithString:[postItemSub.request.url.raw componentsSeparatedByString:@"?"][0] ];
            [finalUrl insertString:@"@\"" atIndex:0];
            [finalUrl insertString:@"\"" atIndex:finalUrl.length];
            
            [txtStr appendString:[NSString stringWithFormat:@"\n\n"]];
            
            //            获取基本路径
            // 生成
            [txtStr appendString:[NSString stringWithFormat:@"#define k%@ %@\n ",defineName,finalUrl]];
            [txtStr appendString:[NSString stringWithFormat:@"#define k%@Parm%@ %@\n ",defineName,postStr,defineStr]];
            
#pragma mark 全局过滤
            txtStr=  [self fixOtherStr:txtStr];

            
            
            
            
            
        }
        
        
        
    }
    NSLog(@"%@",txtStr);
    
    // Do any additional setup after loading the view, typically from a nib.
}

//如果是顿号删除掉
-(NSMutableString *)fixOtherStr:(NSMutableString *)needChangeStr
{
    needChangeStr=  [[needChangeStr stringByReplacingOccurrencesOfString:@"-" withString:@"_"] mutableCopy];
    needChangeStr=  [[needChangeStr stringByReplacingOccurrencesOfString:@"--" withString:@"_"] mutableCopy];
    needChangeStr=  [[needChangeStr stringByReplacingOccurrencesOfString:@"、" withString:@"_"] mutableCopy];
    needChangeStr=  [[needChangeStr stringByReplacingOccurrencesOfString:@"+" withString:@"加"] mutableCopy];
    needChangeStr=  [[needChangeStr stringByReplacingOccurrencesOfString:@"%" withString:@"百分比"] mutableCopy];
    needChangeStr=  [[needChangeStr stringByReplacingOccurrencesOfString:@"\\^H" withString:@""] mutableCopy];
    needChangeStr=  [[needChangeStr stringByReplacingOccurrencesOfString:@"[]" withString:@""] mutableCopy];
    
    return needChangeStr;
    
}
//如果是顿号删除掉
-(NSMutableString *)removeOtherStr:(NSMutableString *)needChangeStr
{
    needChangeStr = [[needChangeStr stringByReplacingOccurrencesOfString:@"//" withString:@"_"] mutableCopy];//删除描述
    needChangeStr = [[needChangeStr stringByReplacingOccurrencesOfString:@" " withString:@"_"] mutableCopy];
    needChangeStr = [[needChangeStr stringByReplacingOccurrencesOfString:@"." withString:@""] mutableCopy];
    
    return needChangeStr;
    
}

//如果是顿号删除掉
-(NSMutableString *)removeLastStr:(NSMutableString *)needChangeStr
{
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@",_"];
    needChangeStr =   [[[needChangeStr copy] stringByTrimmingCharactersInSet:set] mutableCopy];
    
    return needChangeStr;
    
}



- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
        if (jsonString == nil) {
                return nil;
            }
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if(err) {
                NSLog(@"json解析失败：%@",err);
                return nil;
            }
        return dic;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
