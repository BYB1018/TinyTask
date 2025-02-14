import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: '完成 TinyTask UI 升级',
      createdAt: DateTime.now(),
    ),
    Task(
      id: '2',
      title: '添加新功能',
      createdAt: DateTime.now(),
      isCompleted: true,
    ),
  ];
  List<Task> _filteredTasks = [];
  bool _isSearching = false;

  // 获取当前标签页显示的任务列表
  List<Task> get _currentTasks {
    switch (_selectedIndex) {
      case 0: // 全部任务
        return _tasks;
      case 1: // 已完成
        return _tasks.where((task) => task.isCompleted).toList();
      case 2: // 未完成
        return _tasks.where((task) => !task.isCompleted).toList();
      default:
        return _tasks;
    }
  }

  // 获取当前页面标题
  String get _currentTitle {
    switch (_selectedIndex) {
      case 0:
        return '全部任务';
      case 1:
        return '已完成任务';
      case 2:
        return '未完成任务';
      default:
        return '我的任务';
    }
  }

  // 添加新方法：显示新建任务对话框
  void _showAddTaskDialog() {
    final TextEditingController _controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '创建新任务',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: '输入任务内容',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w300,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                ),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.5,
                ),
                maxLines: 3,
                minLines: 1,
                autofocus: true,
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      '取消',
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  ElevatedButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        setState(() {
                          _tasks.add(Task(
                            id: DateTime.now().toString(),
                            title: _controller.text,
                            createdAt: DateTime.now(),
                          ));
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor.withOpacity(0.9),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      '创建',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 添加搜索方法
  void _showSearchDialog() {
    showSearch(
      context: context,
      delegate: TaskSearchDelegate(_tasks),
    );
  }

  // 添加确认删除对话框方法
  Future<bool> _showDeleteConfirmDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.delete_outline,
                size: 48.sp,
                color: Colors.red.withOpacity(0.8),
              ),
              SizedBox(height: 16.h),
              Text(
                '删除任务',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '确定要删除这个任务吗？',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.5,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      '取消',
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.8),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      '删除',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ) ?? false;  // 如果用户点击外部关闭对话框，返回 false
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentTitle,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 26.sp,
            ),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _currentTasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_currentTasks[index].id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20.w),
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.delete_outline,
                color: Colors.red.withOpacity(0.8),
                size: 24.sp,
              ),
            ),
            confirmDismiss: (direction) async {
              return await _showDeleteConfirmDialog(context);
            },
            onDismissed: (direction) {
              final deletedTask = _currentTasks[index];
              final originalIndex = _tasks.indexOf(deletedTask);
              setState(() {
                _tasks.removeAt(originalIndex);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '任务已删除',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5,
                    ),
                  ),
                  action: SnackBarAction(
                    label: '撤销',
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        _tasks.insert(originalIndex, deletedTask);
                      });
                    },
                  ),
                  backgroundColor: Colors.black87.withOpacity(0.8),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  margin: EdgeInsets.all(16.r),
                ),
              );
            },
            child: TaskCard(
              task: _currentTasks[index],
              onTap: () {
                final taskIndex = _tasks.indexOf(_currentTasks[index]);
                setState(() {
                  _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
                });
              },
              onLongPress: () {
                // 实现编辑功能
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedLabelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.5,
          ),
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: Colors.black45,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list, size: 26.sp),
              label: '全部',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done_all, size: 26.sp),
              label: '已完成',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pending_actions, size: 26.sp),
              label: '未完成',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}

// 添加搜索代理类
class TaskSearchDelegate extends SearchDelegate<Task?> {
  final List<Task> tasks;
  
  TaskSearchDelegate(this.tasks);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final List<Task> suggestions = tasks.where((task) {
      return task.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final task = suggestions[index];
        final titleParts = _highlightQuery(task.title);

        return ListTile(
          title: RichText(
            text: TextSpan(
              children: titleParts,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          subtitle: Text(
            '创建于 ${_formatDate(task.createdAt)}',
            style: TextStyle(color: Colors.grey),
          ),
          leading: Icon(
            task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: task.isCompleted ? Colors.green : Colors.grey,
          ),
          onTap: () {
            close(context, task);
          },
        );
      },
    );
  }

  List<TextSpan> _highlightQuery(String title) {
    if (query.isEmpty) return [TextSpan(text: title)];

    final List<TextSpan> spans = [];
    final lowercaseTitle = title.toLowerCase();
    final lowercaseQuery = query.toLowerCase();
    int lastMatchEnd = 0;

    while (true) {
      final int matchStart = lowercaseTitle.indexOf(lowercaseQuery, lastMatchEnd);
      if (matchStart == -1) {
        if (lastMatchEnd < title.length) {
          spans.add(TextSpan(text: title.substring(lastMatchEnd)));
        }
        break;
      }

      if (matchStart > lastMatchEnd) {
        spans.add(TextSpan(text: title.substring(lastMatchEnd, matchStart)));
      }

      spans.add(TextSpan(
        text: title.substring(matchStart, matchStart + query.length),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          backgroundColor: Colors.yellow.withOpacity(0.3),
        ),
      ));

      lastMatchEnd = matchStart + query.length;
    }

    return spans;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
} 