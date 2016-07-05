//
//  ViewController.m
//  Chartdemo
//
//  Created by 涂婉丽 on 16/7/5.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import "ViewController.h"
#import "PYEchartsView.h"
#import "PYOption.h"
#import "RMMapper.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat k_width = [UIScreen mainScreen].bounds.size.width;
    CGFloat k_height = [UIScreen mainScreen].bounds.size.height;
    CGFloat btn_w = (k_width-4*20)/3;
    NSArray *titleArr = @[@"柱状图",@"折线图",@"饼状图"];
    for (int i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((i+1)*20+i*btn_w, k_height-100, btn_w, 40);
        btn.tag = 100+i;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor greenColor]];
        [btn addTarget:self action:@selector(lookChart:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
/**
 *  标准柱状图
 */
-(void)showBasicColumnDemo {
    
    NSString *basicColumnJson = [NSString stringWithFormat:@"{\"grid\":{\"x\":30,\"x2\":45},\"title\":{\"text\":\"%@\"},\"tooltip\":{\"trigger\":\"axis\"},\"legend\":{\"data\":[\"%@\"],\"itemWidth\":\"0\"},\"toolbox\":{\"show\":false,\"feature\":{\"mark\":{\"show\":false},\"dataView\":{\"show\":false,\"readOnly\":true},\"magicType\":{\"show\":false,\"type\":[\"line\",\"bar\"]},\"restore\":{\"show\":false},\"saveAsImage\":{\"show\":false}}},\"calculable\":false,\"xAxis\":[{\"type\":\"category\",\"data\":[\"2013-10-11\",\"2013-12-11\",\"2014-1-11\"]}],\"yAxis\":[{\"type\":\"value\"}],\"series\":[{\"name\":\"%@\",\"type\":\"bar\",\"data\":[135.6,462.2,32.6],\"markPoint\":{\"data\":[{\"type\":\"max\",\"name\":\"最大值\"},{\"type\":\"min\",\"name\":\"最小值\"}]},\"markLine\":{\"data\":[{\"type\":\"average\",\"name\":\"平均值\"}]}}]}",@"门诊",@"门诊",@"门诊"];
    NSData *jsonData = [basicColumnJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
    [_kEchartView setOption:option];
}

/**
 *  标准折线图
 */
-(void)showStandardLineDemo {
    PYOption *option = [[PYOption alloc] init];
    PYTitle *title = [[PYTitle alloc] init];
    title.text = @"三年内变化趋势";
//    title.subtext = @"纯属虚构";
    option.title = title;
    PYTooltip *tooltip = [[PYTooltip alloc] init];
    tooltip.trigger = @"axis";
    option.tooltip = tooltip;
    PYGrid *grid = [[PYGrid alloc] init];
    grid.x = @(40);
    grid.x2 = @(50);
    option.grid = grid;
    PYLegend *legend = [[PYLegend alloc] init];
    legend.data = @[@"门诊"];
    option.legend = legend;
    PYToolbox *toolbox = [[PYToolbox alloc] init];
    toolbox.show = NO;
    toolbox.x = @"right";
    toolbox.y = @"top";
    toolbox.z = @(100);
    toolbox.feature.mark.show = NO;
    toolbox.feature.dataView.show = NO;
    toolbox.feature.dataView.readOnly = YES;
    toolbox.feature.magicType.show = NO;
    toolbox.feature.magicType.type = @[@"line", @"bar"];
    toolbox.feature.restore.show = NO;
    toolbox.feature.saveAsImage.show = NO;
    option.toolbox = toolbox;
    option.calculable = YES;
    PYAxis *xAxis = [[PYAxis  alloc] init];
    xAxis.type = @"category";
    xAxis.boundaryGap = @(NO);
    xAxis.data = @[@"2013-20-12",@"2014-2-4",@"2014-10-12"];
    option.xAxis = [[NSMutableArray alloc] initWithObjects:xAxis, nil];
    PYAxis *yAxis = [[PYAxis alloc] init];
    yAxis.type = @"value";
    yAxis.axisLabel.formatter = @"{value}";
    option.yAxis = [[NSMutableArray alloc] initWithObjects:yAxis, nil];
    PYSeries *series1 = [[PYSeries alloc] init];
    series1.name = @"门诊";
    series1.type = @"line";
    series1.data = @[@(15),@(13),@(10)];
    PYMarkPoint *markPoint = [[PYMarkPoint alloc] init];
    markPoint.data = @[@{@"type" : @"max", @"name": @"最大值"},@{@"type" : @"min", @"name": @"最小值"}];
    series1.markPoint = markPoint;
    PYMarkLine *markLine = [[PYMarkLine alloc] init];
    markLine.data = @[@{@"type" : @"average", @"name": @"平均值"}];
    series1.markLine = markLine;
//    PYSeries *series2 = [[PYSeries alloc] init];
//    series2.name = @"最低温度";
//    series2.type = @"line";
//    series2.data = @[@(1),@(-2),@(2),@(5),@(3),@(2),@(0)];
//    PYMarkPoint *markPoint2 = [[PYMarkPoint alloc] init];
//    markPoint2.data = @[@{@"value" : @(2), @"name": @"周最低", @"xAxis":@(1), @"yAxis" : @(-1.5)}];
//    series2.markPoint = markPoint2;
//    PYMarkLine *markLine2 = [[PYMarkLine alloc] init];
//    markLine2.data = @[@{@"type" : @"average", @"name": @"平均值"}];
//    series2.markLine = markLine2;
    option.series = [[NSMutableArray alloc] initWithObjects:series1, nil];
    [_kEchartView setOption:option];
}
/**
 *  标准饼图
 */
-(void)showBasicPieDemo {
    NSString *basicPieJson = @"{\"title\":{\"text\":\"某站点用户访问来源\",\"subtext\":\"纯属虚构\",\"x\":\"center\"},\"tooltip\":{\"trigger\":\"item\",\"formatter\":\"{a} <br/>{b} : {c} ({d}%)\"},\"legend\":{\"orient\":\"vertical\",\"x\":\"left\",\"data\":[\"直接访问\",\"邮件营销\",\"联盟广告\",\"视频广告\",\"搜索引擎\"]},\"toolbox\":{\"show\":false,\"feature\":{\"mark\":{\"show\":false},\"dataView\":{\"show\":false,\"readOnly\":false},\"magicType\":{\"show\":false,\"type\":[\"pie\",\"funnel\"],\"option\":{\"funnel\":{\"x\":\"25%\",\"width\":\"50%\",\"funnelAlign\":\"left\",\"max\":1548}}},\"restore\":{\"show\":true},\"saveAsImage\":{\"show\":false}}},\"calculable\":false,\"series\":[{\"name\":\"访问来源\",\"type\":\"pie\",\"radius\":\"55%\",\"center\":[\"50%\",\"60%\"],\"data\":[{\"value\":335,\"name\":\"直接访问\"},{\"value\":310,\"name\":\"邮件营销\"},{\"value\":234,\"name\":\"联盟广告\"},{\"value\":135,\"name\":\"视频广告\"},{\"value\":1548,\"name\":\"搜索引擎\"}]}]}";
    NSData *jsonData = [basicPieJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
    [_kEchartView setOption:option];
}
- (void)lookChart:(UIButton *)btn
{

    switch (btn.tag) {
        case 100:
            //柱状图
            [self showBasicColumnDemo];
            [_kEchartView loadEcharts];
            break;
        case 101:
            // 折线图
            [self showStandardLineDemo];
            [_kEchartView loadEcharts];
            break;
        case 102:
            // 饼状图
            [self showBasicPieDemo];
            [_kEchartView loadEcharts];
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
