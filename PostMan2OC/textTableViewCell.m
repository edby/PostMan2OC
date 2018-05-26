//
//  textTableViewCell.m
//  PostMan2OC
//
//  Created by pro on 2018/5/26.
//  Copyright © 2018年 Sat. All rights reserved.
//

#import "textTableViewCell.h"

//______________支付___________

/*
 ______________1_支付宝Alipay生成订单及sign___________
 
 */


#define kAlipayGet_Order @"https://super.api.yoawo.com/Alipay/get_order"
#define kAlipayGet_OrderParm(用户登录token,地区名称,支付类型_1现金充值_2诺券激活_3优惠券_4代金券,诺券码或优惠券码或兑换券码,充值金额,支付客户端__1__ios____2__微信小程序___3__android,诺券是否批量激活___0否_1是) @{@"token":用户登录token,@"area_name":地区名称,@"pay_type":支付类型_1现金充值_2诺券激活_3优惠券_4代金券,@"tickets_code":诺券码或优惠券码或兑换券码,@"price":充值金额,@"pay_from":支付客户端__1__ios____2__微信小程序___3__android,@"pay_batch":诺券是否批量激活___0否_1是}
/*
 ______________2_微信支付生成订单及sign___________
 
 */


#define kWxGet_Order @"https://super.api.yoawo.com/wx/get_order"
#define kWxGet_OrderParm(用户登录token,地区ID,支付类型_1现金充值_2诺券激活_3优惠券_4兑换券,_诺券码_优惠券码_兑换券码,充值金额,支付客户端__1__ios____2__微信小程序___3__android,诺券是否批量激活___0否_1是) @{@"token":用户登录token,@"area_id":地区ID,@"pay_type":支付类型_1现金充值_2诺券激活_3优惠券_4兑换券,@"tickets_code":_诺券码_优惠券码_兑换券码,@"price":充值金额,@"pay_from":支付客户端__1__ios____2__微信小程序___3__android,@"pay_batch":诺券是否批量激活___0否_1是}
/*
 ______________3_微信测试返回签名信息___________
 
 */


#define kApiPhpAppWeixinGetordersn @"https://app.yoawo.com/api.php/app/Weixin/getOrderSn"
#define kApiPhpAppWeixinGetordersnParm(支付客户端_1__ios__2__微信小程序__3__android,微信小程序支付传入openid) @{@"pay_from":支付客户端_1__ios__2__微信小程序__3__android,@"openid":微信小程序支付传入openid}
/*
 ______________4_支付宝测试返回签名信息___________
 
 */


#define kApiPhpAppAlipayGetordersn @"http://app.yoawo.com/api.php/app/Alipay/getOrderSn"
#define kApiPhpAppAlipayGetordersnParm() @{}
/*
 ______________5_云握2.0全民推广微信支付获取签名___________
 
 */


#define kPaySpreadGet_Sign @"https://super.api.yoawo.com/Pay/spread/get_sign"
#define kPaySpreadGet_SignParm(用户登录token,活动ID,支付客户端__1__ios_2__微信小程序_3__android,活动价格,小程序支付openid,购买数量,购买颜色,邀请人ID,分享邀请时间戳加随机数,邀请链接中的时间戳) @{@"token":用户登录token,@"spread_id":活动ID,@"pay_from":支付客户端__1__ios_2__微信小程序_3__android,@"price":活动价格,@"openid":小程序支付openid,@"amount":购买数量,@"color":购买颜色,@"invite_user_id":邀请人ID,@"times":分享邀请时间戳加随机数,@"invite_timestr":邀请链接中的时间戳}
/*
 ______________6_云握2.0钞票雨微信支付获取签名___________
 
 */


#define kPayCoinGet_Sign @"https://app.yoawo.com/Pay/coin/get_sign"
#define kPayCoinGet_SignParm(用户登录token,支付类型_1现金充值,充值金额_20_50_100_200,支付客户端__1__ios__2__微信小程序_3__android,钞票雨活动ID,微信小程序支付openid___APP此参数可省略) @{@"token":用户登录token,@"pay_type":支付类型_1现金充值,@"price":充值金额_20_50_100_200,@"pay_from":支付客户端__1__ios__2__微信小程序_3__android,@"coin_id":钞票雨活动ID,@"openid":微信小程序支付openid___APP此参数可省略}

//______________全民推广___________

/*
 ______________1_保存基本信息___________
 
 */


#define kApiSpread_Base @"http://super.duidui.com/Api/spread_base"
#define kApiSpread_BaseParm(商户登录token,地区名,商家名称,联系电话,联系地址,商品名称,广告类型_0图片_1视频,上传视频,上传GIF_多个用英文逗号分隔,商品描述,开始时间,活动截止时间,商品颜色,stop_time,图片数组,android图片，多个用英文逗号分隔) @{@"token":商户登录token,@"area_name":地区名,@"seller":商家名称,@"contact_number":联系电话,@"address":联系地址,@"product_name":商品名称,@"attach_type":广告类型_0图片_1视频,@"video":上传视频,@"gif":上传GIF_多个用英文逗号分隔,@"product_intro":商品描述,@"start_at":开始时间,@"stop_at":活动截止时间,@"product_color":商品颜色,@"stop_time":stop_time,@"pics":图片数组,@"pics_android":android图片，多个用英文逗号分隔}
/*
 ______________2_保存赏金设置___________
 
 */


#define kApiSpread_Reward @"https://super.api.yoawo.com/Api/spread_reward"
#define kApiSpread_RewardParm(商家登录token,活动ID,市场价,活动价格,赏金上限_0_不限制_1_100百分比___2__200百分比,数量上限,用户获取赏金方式_0金额_1百分比,消费者购买才能获得推广和邀请资格_0否_1是,不购买仅分享邀请赏金金额,平台收取不购买仅分享服务费金额,用户购买分享邀请赏金金额,平台收取购买分享服务费金额,不购买仅推广赏金比例,不购买平台收取仅分享服务费百分比_默认值_16百分比,购买并推广赏金比例,平台收取购买分享服务费百分比_默认值_26百分比,_,按金额___不购买仅分享邀请赏金金额,按金额____平台收取不购买仅分享服务费金额,按金额____用户购买分享邀请赏金金额,按金额____平台收取购买分享服务费金额) @{@"token":商家登录token,@"spread_id":活动ID,@"market_price":市场价,@"price":活动价格,@"reward_limit":赏金上限_0_不限制_1_100百分比___2__200百分比,@"amount_limit":数量上限,@"user_obtain":用户获取赏金方式_0金额_1百分比,@"is_buy_qualify":消费者购买才能获得推广和邀请资格_0否_1是,@"user_share_money":不购买仅分享邀请赏金金额,@"platform_share_money":平台收取不购买仅分享服务费金额,@"user_buy_money":用户购买分享邀请赏金金额,@"platform_buy_money":平台收取购买分享服务费金额,@"reward_rate":不购买仅推广赏金比例,@"platform_share_rate":不购买平台收取仅分享服务费百分比_默认值_16百分比,@"buy_reward_rate":购买并推广赏金比例,@"platform_buy_rate":平台收取购买分享服务费百分比_默认值_26百分比,@"_":_,@"muser_share_money":按金额___不购买仅分享邀请赏金金额,@"mplatform_share_money":按金额____平台收取不购买仅分享服务费金额,@"muser_buy_money":按金额____用户购买分享邀请赏金金额,@"mplatform_buy_money":按金额____平台收取购买分享服务费金额}
/*
 ______________3_提交活动___________
 
 */


#define kApiSpread_Submit @"https://super.api.yoawo.com/Api/spread_submit"
#define kApiSpread_SubmitParm(商家登录token,活动ID) @{@"token":商家登录token,@"spread_id":活动ID}
/*
 ______________4_赚赏金 全民推广 活动列表___________
 
 */


#define kApiSpread_List @"https://super.api.yoawo.com/Api/spread_list"
#define kApiSpread_ListParm(用户登录token,当前页码,每页显示记录条数) @{@"token":用户登录token,@"page":当前页码,@"rows":每页显示记录条数}
/*
 ______________5_活动详细___________
 
 */


#define kApiSpread_Info @"http://super.duidui.com/Api/spread_info"
#define kApiSpread_InfoParm(用户登录token,活动ID,分享链接进入页面的时间戳,邀请人ID) @{@"token":用户登录token,@"spread_id":活动ID,@"times":分享链接进入页面的时间戳,@"invite_user_id":邀请人ID}
/*
 ______________6_获取剩余库存数量___________
 
 */


#define kApiSpread_Overplus @"https://super.api.yoawo.com/Api/spread_overplus"
#define kApiSpread_OverplusParm(token,spread_id) @{@"token":token,@"spread_id":spread_id}
/*
 ______________7_我的发售列表___________
 
 */


#define kApiSpread_My @"http://super.duidui.com/Api/spread_my"
#define kApiSpread_MyParm(用户或商家登录token,当前页码_默认0,每页显示记录条数_默认10,_2已结束_1进行中) @{@"token":用户或商家登录token,@"page":当前页码_默认0,@"row":每页显示记录条数_默认10,@"status":2_已结束_1进行中}
/*
 ______________8_我的发售详细___________
 
 */


#define kApiSpread_My_Detail @"http://super.duidui.com/Api/spread_my_detail"
#define kApiSpread_My_DetailParm(用户登录token,活动ID,_邀请好友ID__邀请人,分销商分享时间戳) @{@"token":用户登录token,@"spread_id":活动ID,@"invite_user_id":_邀请好友ID__邀请人,@"times":分销商分享时间戳}
/*
 ______________9_商家已售商品列表___________
 
 */


#define kApiSales @"https://super.api.yoawo.com/Api/sales"
#define kApiSalesParm(登录token,全民推广活动ID,___1待兑换_2已失效,当前页码_默认0,每页显示记录条数_默认10) @{@"token":登录token,@"spread_id":全民推广活动ID,@"status":___1待兑换_2已失效,@"page":当前页码_默认0,@"rows":每页显示记录条数_默认10}
/*
 ______________10_全民推广分享成功回调 首次发售___________
 
 */


#define kApiSpread_Share_Ok @"https://super.api.yoawo.com/Api/spread_share_ok"
#define kApiSpread_Share_OkParm(活动ID,邀请人ID,当前用户ID（被邀请人_分享信息的用户ID）,购买商品订单ID,分享邀请链接中的时间戳加随机数,邀请链接中的_时间戳) @{@"spread_id":活动ID,@"invite_user_id":邀请人ID,@"current_user_id":当前用户ID（被邀请人_分享信息的用户ID）,@"order_id":购买商品订单ID,@"times":分享邀请链接中的时间戳加随机数,@"invite_timestr":邀请链接中的_时间戳}
/*
 ______________11_全民推广活动详细___________
 
 */


#define kApiSpread_Detail @"https://super.api.yoawo.com/Api/spread_detail"
#define kApiSpread_DetailParm(登录token,活动ID) @{@"token":登录token,@"spread_id":活动ID}
/*
 ______________12_分享成功回调函数  再次发售___________
 
 */


#define kApiSpread_Share_Again @"https://super.api.yoawo.com/Api/spread_share_again"
#define kApiSpread_Share_AgainParm(活动ID,邀请人ID,当前用户ID,订单编号ID,分享邀请链接中的时间戳加随机数,邀请链接中的时间戳) @{@"spread_id":活动ID,@"invite_user_id":邀请人ID,@"current_user_id":当前用户ID,@"order_id":订单编号ID,@"times":分享邀请链接中的时间戳加随机数,@"invite_timestr":邀请链接中的时间戳}
/*
 ______________3_商家立即已确认 发货操作___________
 
 */


#define kApiSpread_Send @"https://super.api.yoawo.com/Api/spread_send"
#define kApiSpread_SendParm(token,tickets_code) @{@"token":token,@"tickets_code":tickets_code}
/*
 ______________13_全民推广 购买判断是否还有库存___________
 
 */


#define kApiSpread_Amount @"https://super.api.yoawo.com/Api/spread_amount"
#define kApiSpread_AmountParm(活动ID,购买数量) @{@"spread_id":活动ID,@"amount":购买数量}

//______________微名片___________

/*
 ______________1_获取微名片信息___________
 
 */


#define kApiCard_Info @"https://super.api.yoawo.com/Api/card_info"
#define kApiCard_InfoParm(登录token,微名片ID) @{@"token":登录token,@"tiny_id":微名片ID}
/*
 ______________2_微名片新增_编辑请求___________
 
 */


#define kApiCard_Add_Depose @"https://super.api.yoawo.com/Api/card_add_depose"
#define kApiCard_Add_DeposeParm(用户登录token,微名片ID,门店名称,所属行业ID,联系地址,经度,纬度,营业时间,店内设置__0wifi__1停车位_2支付宝支付_3微信支付,是否支持锘_1_支持（V盟）_0_不支持,照片,照片（最多九张）多个用英文逗号分隔,门店简介,联系电话) @{@"token":用户登录token,@"tiny_id":微名片ID,@"org_name":门店名称,@"industry":所属行业ID,@"address":联系地址,@"org_lng":经度,@"org_lat":纬度,@"shop_hours":营业时间,@"shop_setting":店内设置__0wifi__1停车位_2支付宝支付_3微信支付,@"is_support_nuo":是否支持锘_1_支持（V盟）_0_不支持,@"logo":照片,@"photos":照片（最多九张）多个用英文逗号分隔,@"intro":门店简介,@"phone":联系电话}
/*
 ______________3_保存私信信息___________
 
 */


#define kApiLetter_Add @"https://super.api.yoawo.com/Api/letter_add"
#define kApiLetter_AddParm(用户登录token,发送给用户ID,用户登录ID,内容) @{@"token":用户登录token,@"to_userid":发送给用户ID,@"from_userid":用户登录ID,@"content":内容}
/*
 ______________4_我的私信列表___________
 
 */


#define kApiMy_Letter @"https://super.api.yoawo.com/Api/my_letter"
#define kApiMy_LetterParm(用户登录token,当前页_默认0_第一页,每页显示记录条数_默认1000_（不分页）) @{@"token":用户登录token,@"page":当前页_默认0_第一页,@"rows":每页显示记录条数_默认1000_（不分页）}
/*
 ______________5_我的私信列表 商家与某用户所有聊天记录___________
 
 */


#define kApiMy_Letter_Details @"https://super.api.yoawo.com/Api/my_letter_details"
#define kApiMy_Letter_DetailsParm(登录用户或商家token,消息ID,当前页码_默认0_第一页,每页显示记录条数__默认1000_不分页) @{@"token":登录用户或商家token,@"MsgId":消息ID,@"page":当前页码_默认0_第一页,@"rows":每页显示记录条数__默认1000_不分页}
/*
 ______________6_我的私信列表 商家与某用户所有聊天记录 用户点击___________
 
 */


#define kApiUser_Letters @"https://super.api.yoawo.com/Api/user_letters"
#define kApiUser_LettersParm(用户登录token,商家用户ID,page,rows) @{@"token":用户登录token,@"spread_id":商家用户ID,@"page":page,@"rows":rows}

//______________钞票雨___________

/*
 ______________10_钞票雨活动预报列表___________
 
 */


#define kApiCoin_Forecast_List @"https://super.api.yoawo.com/Api/coin_forecast_list"
#define kApiCoin_Forecast_ListParm(登录token,地区名称) @{@"token":登录token,@"area_name":地区名称}
/*
 ______________11_钞票雨用户_商家排行top20 ___________
 
 */


#define kApiCoin_Rank @"https://super.api.yoawo.com/Api/coin_rank"
#define kApiCoin_RankParm(用户登录token,排行类型__0用户_1商家) @{@"token":用户登录token,@"user_type":排行类型__0用户_1商家}
/*
 ______________12_发起钞票雨基本资料接口___________
 
 */


#define kApiCoin_Basic @"http://super.duidui.com/Api/coin_basic"
#define kApiCoin_BasicParm(登录token,主题名称,活动描述,广告类型__0图片_1视频,活动图片__多个用英文逗号分隔,活动开始日期,活动开始时间,广告图GIF__多个用英文逗号分隔,活动视频) @{@"token":登录token,@"event_theme":主题名称,@"event_desc":活动描述,@"attach_type":广告类型__0图片_1视频,@"asset":活动图片__多个用英文逗号分隔,@"start_date":活动开始日期,@"start_time":活动开始时间,@"pics":广告图GIF__多个用英文逗号分隔,@"video":活动视频}
/*
 ______________13_钞票雨结算页面___________
 
 */


#define kApiCoin_Balance @"https://super.api.yoawo.com/Api/coin_balance"
#define kApiCoin_BalanceParm(token,coin_id) @{@"token":token,@"coin_id":coin_id}
/*
 ______________14_钞票雨开始___________
 
 */


#define k @"ws://39.104.78.93:9501"
#define kParm() @{}
/*
 ______________15_钞票雨接龙占位列表页面___________
 
 */


#define kApiCoin_Sequence @"http://super.duidui.com/Api/coin_sequence"
#define kApiCoin_SequenceParm(token) @{@"token":token}
/*
 ______________16_发起钞票雨基本资料接口___________
 
 */


#define kApiCoin_Basic @"https://super.api.yoawo.com/Api/coin_basic"
#define kApiCoin_BasicParm(登录token,活动主题名称,活动描述,活动图片_多个用英文逗号分隔,活动开始日期,活动开始时间,广告类型__0图片_1视频,广告图GIF,活动视频,邀请人user_id) @{@"token":登录token,@"event_theme":活动主题名称,@"event_desc":活动描述,@"asset":活动图片_多个用英文逗号分隔,@"start_date":活动开始日期,@"start_time":活动开始时间,@"attach_type":广告类型__0图片_1视频,@"pics":广告图GIF,@"video":活动视频,@"invite_user_id":邀请人user_id}
/*
 ______________17_选择充值套餐___________
 
 */


#define kApiCoin_Package @"https://super.api.yoawo.com/Api/coin_package"
#define kApiCoin_PackageParm(登录token,活动ID,套餐充值金额_20_50_100_200,诺_现金最小拆分面额,诺_现金最大拆分面额,诺_现金拆分数量) @{@"token":登录token,@"coin_id":活动ID,@"combo_amount":套餐充值金额_20_50_100_200,@"coin_min_bonus":诺_现金最小拆分面额,@"coin_max_bonus":诺_现金最大拆分面额,@"coin_split_num":诺_现金拆分数量}
/*
 ______________18_扣除用户幸运星进入钞票雨活动___________
 
 */


#define kApiStar_Num @"https://super.api.yoawo.com/Api/star_num"
#define kApiStar_NumParm(登录token) @{@"token":登录token}
/*
 ______________19_钞票雨添加优惠券___________
 
 */


#define kApiCoin_Pkg_Coupon @"https://super.api.yoawo.com/Api/coin_pkg_coupon"
#define kApiCoin_Pkg_CouponParm(登录token,钞票雨活动ID,优惠券数量,优惠券满消费金额,优惠券减金额,优惠券有效期) @{@"token":登录token,@"coin_id":钞票雨活动ID,@"coupon_num":优惠券数量,@"coupon_consume":优惠券满消费金额,@"coupon_minus":优惠券减金额,@"coupon_expire":优惠券有效期}
/*
 ______________20_钞票雨添加代金券___________
 
 */


#define kApiCoin_Pkg_Voucher @"https://super.api.yoawo.com/Api/coin_pkg_voucher"
#define kApiCoin_Pkg_VoucherParm(用户登录token,钞票雨活动ID,代金券总金额,代金券最小拆分金额,代金券最大拆分金额,代金卷拆分数量,代金券有效期) @{@"token":用户登录token,@"coin_id":钞票雨活动ID,@"voucher_amount":代金券总金额,@"voucher_min_bonus":代金券最小拆分金额,@"voucher_max_bonus":代金券最大拆分金额,@"voucher_split_num":代金卷拆分数量,@"voucher_expire":代金券有效期}
/*
 ______________21_发起钞票雨添加广告文案___________
 
 */


#define kApiCoin_Add_Ad @"https://super.api.yoawo.com/Api/coin_add_ad"
#define kApiCoin_Add_AdParm(用户登录token,广告文案,钞票雨活动ID) @{@"token":用户登录token,@"ad_words":广告文案,@"coin_id":钞票雨活动ID}
/*
 ______________22_发起钞票雨添加广告图片___________
 
 */


#define kApiCoin_Add_Thumb @"https://super.api.yoawo.com/Api/coin_add_thumb"
#define kApiCoin_Add_ThumbParm(用户登录token,表单文件名称,钞票雨活动ID) @{@"token":用户登录token,@"file":表单文件名称,@"coin_id":钞票雨活动ID}
/*
 ______________23_全民推广删除广告___________
 
 */


#define kApiCoin_Adv_Del @"https://super.api.yoawo.com/Api/coin_adv_del"
#define kApiCoin_Adv_DelParm(用户登录token,广告ID) @{@"token":用户登录token,@"adv_id":广告ID}
/*
 ______________24_发起钞票雨添加广告图片（APP）___________
 
 */


#define kApiCoin_App_Thumb @"https://super.api.yoawo.com/Api/coin_app_thumb"
#define kApiCoin_App_ThumbParm(用户登录token,oss图片URL地址,活动ID) @{@"token":用户登录token,@"url":oss图片URL地址,@"coin_id":活动ID}
/*
 ______________25_钞票雨详细___________
 
 */


#define kApiCoin_Detail @"https://super.api.yoawo.com/Api/coin_detail"
#define kApiCoin_DetailParm(用户登录token,活动ID) @{@"token":用户登录token,@"coin_id":活动ID}

//______________签到机及兑兑幸运星___________

/*
 ______________1_签到机获取幸运星___________
 
 */


#define kApiCheck_In_Star @"https://super.api.yoawo.com/Api/check_in_star"
#define kApiCheck_In_StarParm(用户登录token) @{@"token":用户登录token}
/*
 ______________3_兑兑幸运星点击分享前判断  每人每天最多分享5次___________
 
 */


#define kApiShare_Before_Star @"https://super.api.yoawo.com/Api/share_before_star"
#define kApiShare_Before_StarParm(token) @{@"token":token}
/*
 ______________5_兑兑幸运星 领取者奖励 第一个领取者奖励5个幸运星 分享者5个奖励___________
 
 */


#define kApiShare_Get_Star @"https://super.api.yoawo.com/Api/share_get_star"
#define kApiShare_Get_StarParm(用户登录token,分享链接中的时间戳,分享的用户ID) @{@"token":用户登录token,@"time_str":分享链接中的时间戳,@"share_user_id":分享的用户ID}
/*
 ______________4_兑兑幸运星分享成功 给用户 分享奖励5个幸运星___________
 
 */


#define kApiShare_Duidui_Star @"https://super.api.yoawo.com/Api/share_duidui_star"
#define kApiShare_Duidui_StarParm(用户登录token,时间戳) @{@"token":用户登录token,@"time_str":时间戳}
/*
 ______________我的幸运星流水___________
 
 */


#define kApiStar_Record @"http://super.duidui.com/Api/star_record"
#define kApiStar_RecordParm(token) @{@"token":token}

//______________我的钱包___________

/*
 ______________1_商品码列表___________
 
 */


#define kApiProduct_Codes @"https://super.api.yoawo.com/Api/product_codes"
#define kApiProduct_CodesParm(登录token,__1未使用_2已失效,当前页码_默认0_第一页,每页显示记录条数_默认10) @{@"token":登录token,@"status":__1未使用_2已失效,@"page":当前页码_默认0_第一页,@"rows":每页显示记录条数_默认10}
/*
 ______________2_用户立即兑换操作___________
 
 */


#define kApiExchange @"https://super.api.yoawo.com/Api/exchange"
#define kApiExchangeParm(用户登录token,商品码) @{@"token":用户登录token,@"tickets_code":商品码}
/*
 ______________3_用户确认收货___________
 
 */


#define kApiSpread_User_Confirm @"https://super.api.yoawo.com/Api/spread_user_confirm"
#define kApiSpread_User_ConfirmParm(token,tickets_code) @{@"token":token,@"tickets_code":tickets_code}

//______________去消费___________

/*
 ______________1_行业分类列表___________
 
 */


#define kApiIndustry @"https://super.api.yoawo.com/Api/industry"
#define kApiIndustryParm() @{}
/*
 ______________2_去消费banner列表___________
 
 */


#define kApiConsume_Banner @"https://super.api.yoawo.com/Api/consume_banner"
#define kApiConsume_BannerParm(地区名称) @{@"city_name":地区名称}
/*
 ______________3_根据行业类别，获取微名片信息表___________
 
 */


#define kApiConsume_Vcard_List @"https://super.api.yoawo.com/Api/consume_vcard_list"
#define kApiConsume_Vcard_ListParm(用户登录token,行业分类ID,地区名称,当前页码默认0_第一页,每页显示记录条数) @{@"token":用户登录token,@"industry_id":行业分类ID,@"area_name":地区名称,@"page":当前页码默认0_第一页,@"rows":每页显示记录条数}

//--------------2、首页获取系统信息-----------


//--------------6、微信登录授权-----------


//--------------9、开放城市列表-----------


//--------------23、上传图片到OSS-----------


//--------------24、小程序二维码(圆形、方形)-----------


//--------------25、app登录-----------


//--------------我的-----------

@implementation textTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
