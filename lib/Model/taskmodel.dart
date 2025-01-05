class ModalTaskCard {
  int? taskId;
  int isfinished;
  String title;
  String description;
  String date;
  String? priority;

  ModalTaskCard({
    this.taskId,
    required this.title,
    required this.description,
    required this.date,
    required this.isfinished,
    this.priority,
  });

  Map<String, dynamic> taskMap() {
    return {
      // 'taskId': taskId,
      'isfinished': isfinished,
      'title': title,
      'description': description,
      'date': date,
      'priority': priority,
    };
  }
}
