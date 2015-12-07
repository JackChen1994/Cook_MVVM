# 天天掌厨
基于MVVM框架开发的菜谱App
基本功能:搜索, 分类, 收藏
</br>
# 主界面
主体为TableView, 自定义一个ScrollerView作为tableHeaderView
</br>
![image](https://github.com/JackChen1994/Cook_MVVM/blob/master/Images/Image01.png)
# 分类菜单
左边是TableView, 右边为CollectionView, 选中tableView中的分类, 右边会自动跳转小分类
</br>
![image](https://github.com/JackChen1994/Cook_MVVM/blob/master/Images/Image02.png)
# 大图列表
右上角切到小图界面
集成MJRefresh的上拉刷新和下拉加载, 动画为自带的"吃包子"动画
</br>
![image](https://github.com/JackChen1994/Cook_MVVM/blob/master/Images/Image03.png)
# 小图列表
![image](https://github.com/JackChen1994/Cook_MVVM/blob/master/Images/Image04.png)
# 详情界面
主体为TableView, 自定义一个View作为tableHeaderView
点击图片上的"爱心"button可以完成收藏
如果"爱心"变为高亮,则收藏成功
</br>
![imag主体为TableView, 自定义一个ScrollerView作为tableHeaderViewe](https://github.com/JackChen1994/Cook_MVVM/blob/master/Images/Image05.png)
# 收藏界面
显示收藏的数据
使用FlieManager写plist文件实现收藏
</br>
![image](https://github.com/JackChen1994/Cook_MVVM/blob/master/Images/Image06.png)
