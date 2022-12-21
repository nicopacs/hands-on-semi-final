class Model{
  final int id, userId;
   String title;
   bool completed;

  Model({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed});

  factory Model.fromJson(Map<String, dynamic> json){
    return Model(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed']
    );
  }

}