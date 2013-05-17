//
//  HFTestHashing.m
//  HexFiend_2
//
//  Copyright 2008 ridiculous_fish. All rights reserved.
//

#if HFUNIT_TESTS

#import <HexFiend/HFTestHashing.h>
#import <HexFiend/HFByteArray.h>
#include <CommonCrypto/CommonDigest.h>

NSData *HFHashFile(NSURL *url) {
    NSMutableData *data = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_CTX ctx;
    memset(&ctx, 0, sizeof ctx);
    CC_SHA1_Init(&ctx);
    
    REQUIRE_NOT_NULL(url);
    HFASSERT([url isFileURL]);
    const NSUInteger bufferSize = 1024 * 1024 * 4;
    unsigned char *buffer = malloc(bufferSize);
    NSInteger amount;
    NSInputStream *stream = [[NSInputStream alloc] initWithFileAtPath:[url path]];
    [stream open];
    while ((amount = [stream read:buffer maxLength:bufferSize]) > 0) {
        assert(amount == (CC_LONG)amount);
        CC_SHA1_Update(&ctx, buffer, (CC_LONG)amount);
    }
    [stream close];
    CC_SHA1_Final([data mutableBytes], &ctx);
    free(buffer);
    return data;
}

NSData *HFHashByteArray(HFByteArray *array) {
    REQUIRE_NOT_NULL(array);
    NSMutableData *data = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_CTX ctx;
    memset(&ctx, 0, sizeof ctx);
    CC_SHA1_Init(&ctx);
    
    const NSUInteger bufferSize = 1024 * 1024 * 4;
    unsigned char *buffer = malloc(bufferSize);
    unsigned long long offset = 0, length = [array length];
    while (offset < length) {
        NSUInteger amount = bufferSize;
        if (amount > (length - offset)) amount = ll2l(length - offset);
        [array copyBytes:buffer range:HFRangeMake(offset, amount)];
        assert(amount == (CC_LONG)amount);
        CC_SHA1_Update(&ctx, buffer, (CC_LONG)amount);
        offset += amount;
    }
    CC_SHA1_Final([data mutableBytes], &ctx);
    free(buffer);
    return data;
}


#endif
