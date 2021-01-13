class Task {
  static const tblTask = 'Task';
  static const colId = 'id';
  static const colTitle = 'title';
  static const colPriority = 'priority';
  static const colStatus = 'status';

  int id;
  String title;
  String priority;
  int status;

  Task({
    this.title,
    this.priority,
    this.status,
  });
  Task.withId({
    this.id,
    this.title,
    this.priority,
    this.status,
  });

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map[colId] = id;
    }
    map[colTitle] = title;
    map[colPriority] = priority;
    map[colStatus] = status;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map[colId],
      title: map[colTitle],
      priority: map[colPriority],
      status: map[colStatus],
    );
  }
}
