//
//  NSData+CRC32.h
//  TodayNews
//
//  Created by ketianxiahui on 2018/12/18.
//  Copyright © 2018 Hi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <zlib.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (CRC32)

-(int32_t)crc_32;

-(uLong)getCRC32;

@end

NS_ASSUME_NONNULL_END
