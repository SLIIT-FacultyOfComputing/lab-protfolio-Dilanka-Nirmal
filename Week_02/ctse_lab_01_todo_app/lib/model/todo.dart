// Model class for ToDo
class ToDo {
  String? id;
  String? todoText;
  bool isDone;

// Constructor
  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

// Initialize the list of ToDo
  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'CTSE Lectures', isDone: true),
      ToDo(id: '02', todoText: 'CTSE Labs', isDone: true),
      ToDo(
        id: '03',
        todoText: 'CTSE Tutorial',
      ),
      ToDo(
        id: '04',
        todoText: 'IUP Lectures',
      ),
      ToDo(
        id: '05',
        todoText: 'IUP Labs',
      ),
      ToDo(
        id: '06',
        todoText: 'Meeting with the Supervisor',
      ),
    ];
  }
}
