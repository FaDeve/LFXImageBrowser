//
//  CDStatus+CoreDataProperties.h
//  LWAsyncDisplayViewDemo
//
//  Created by 刘微 on 16/4/4.
//  Copyright © 2016年 WayneInc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CDStatus.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDStatus (CoreDataProperties)

@property (nullable, nonatomic, retain) NSURL* avatar;
@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSArray* imgs;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *statusID;
@property (nullable, nonatomic, retain) NSArray* commentList;

@end

NS_ASSUME_NONNULL_END
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com