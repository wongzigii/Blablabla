//
//  Constant.h
//  Blablabla
//
//  Created by Wongzigii on 15/3/21.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#ifndef Blablabla_Constant_h
#define Blablabla_Constant_h

#define kXMPP_HOST                @"127.0.0.1"
#define kXMPP_PORT                5222
#define kXMPP_DOMAIN              @"blablablaopenfireserver"

#define kXMPP_ROSTER_CHANGE       @"XMPP_ROSTER_CHANGE"
#define kXMPP_MESSAGE_CHANGE      @"kXMPP_MESSAGE_CHANGE"
#define kKEYBOARD_FRAME_CHANGE    @"kKEYBOARD_FRAME_CHANGE"
#define kKEYBOARD_HIDE            @"kKEYBOARD_HIDE"

#if TARGET_OS_IPHONE
#define kRESOURCE @"iOS"
#elif TARGET_OS_MAC
#define kRESOURCE @"Mac"
#endif

#endif
