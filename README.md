![logo](https://images.gitee.com/uploads/images/2019/0105/152220_3c77fcbf_1941860.png "在这里输入图片标题")


![home page](https://images.gitee.com/uploads/images/2019/0101/174701_5bd8e5e2_1941860.png "在这里输入图片标题")

当滑动列表的时候，控制会打印LCUS为前缀的所有调用，可以看到滑动的过程中究竟调用了哪些方法

When the list is swiped, the control prints all calls that are prefixed by LCUS, and you can see which methods were called during the sliding process.

![console](https://images.gitee.com/uploads/images/2019/0101/174841_4d296b8d_1941860.png "在这里输入图片标题")

#### 介绍
objective-c行为记录器，跟踪objc_msgSend

Objective-c behavior recorder, tracking objc_msgSend

#### 使用说明

* 模拟器使用, 勾选hook_objc_msgSend_x86.s参与编译 (Use by the simulator, check hook_objc_msgSend_x86.s to compile)
* 真机使用5s以上机型，勾选hook_objc_msgSend.s参与编译 (Real machine use 5s or more models, check hook_objc_msgSend.s to compile)


#### 注意事项

* 过滤器LCSFilterBlock中不能再次调用objc_send, 也就是调用oc方法（包括NSLog），会导致无限循环。(
The objc_send cannot be called again in the filter LCSFilterBlock, that is, calling the oc method (including NSLog) will result in an infinite loop.)
* 目前此实现目的仅用于调试，不要用于线上代码。(
Currently this implementation is only for debugging purposes, not for online code.)
#### 大家使用有问题，欢迎提issues (There is a problem with everyone, welcome to mention issues)
