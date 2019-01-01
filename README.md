# locus

![home page](https://images.gitee.com/uploads/images/2019/0101/174701_5bd8e5e2_1941860.png "在这里输入图片标题")
当滑动列表的时候，控制会打印LCUS为前缀的所有调用，可以看到滑动的过程中究竟调用了哪些方法
![console](https://images.gitee.com/uploads/images/2019/0101/174841_4d296b8d_1941860.png "在这里输入图片标题")

#### 介绍
objective-c行为记录器，跟踪objc_send


#### 使用说明

模拟器使用, 勾选hook_objc_msgSend_x86.s参与编译
真机使用5s以上机型，勾选hook_objc_msgSend.s参与编译


#### 注意事项

* 过滤器LCSFilterBlock中不能再次调用objc_send, 也就是调用oc方法（包括NSLog），会导致无限循环。
* 目前此实现目的仅用于调试，不要用于线上代码。
* 大家使用有问题，欢迎提issues
