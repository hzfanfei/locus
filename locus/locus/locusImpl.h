//
//  hookObjcSend.h
//  fishhookdemo
//
//  Created by FanFamily on 2018/7/21.
//  Copyright © 2018年 Family Fan. All rights reserved.
//

#ifndef hookObjcSend_h
#define hookObjcSend_h

typedef int(^LCSFilterBlock)(char* className, char* selName);

void lcs_start(LCSFilterBlock block);
void lcs_stop_print();
void lcs_resume_print();

#endif /* hookObjcSend_h */
