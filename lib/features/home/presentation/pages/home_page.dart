import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/auth.dart';
import '../../../students/students.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Estudiantes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          context.select((AuthBloc bloc) {
            final token = (bloc.state as AuthSuccessWithToken).token;
            return Text('Token de acceso: $token');
          }),
          _buildWelcomeCard(),
          Expanded(
            child: BlocBuilder<StudentsBloc, StudentsState>(
              builder: (context, state) {
                if (state is StudentsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is StudentsLoaded) {
                  return StudentList(
                    students: state.students,
                    onDelete: (id) => _showDeleteDialog(context, id),
                    onUpdate: (student) => _showUpdateDialog(context, student),
                  );
                } else if (state is StudentsError) {
                  return Center(child: Text('Error: ${state.failure}'));
                } else {
                  return const Center(
                      child: Text('No hay estudiantes disponibles.'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return const Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '¡Bienvenido a la Gestión de Estudiantes!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Aquí puedes gestionar la lista de estudiantes. Puedes agregar, modificar y eliminar estudiantes.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => StudentDialog(
        title: 'Agregar Estudiante',
        onSubmit: (student) {
          context.read<StudentsBloc>().add(AddStudent(student));
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, Student student) {
    showDialog(
      context: context,
      builder: (context) => StudentDialog(
        title: 'Modificar Estudiante',
        student: student,
        onSubmit: (updatedStudent) {
          context.read<StudentsBloc>().add(UpdateStudent(updatedStudent));
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Estudiante'),
        content:
            const Text('¿Estás seguro de que deseas eliminar este estudiante?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<StudentsBloc>().add(DeleteStudent(id));
              Navigator.of(context).pop();
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class StudentList extends StatelessWidget {
  final List<Student> students;
  final void Function(int) onDelete;
  final void Function(Student) onUpdate;

  const StudentList({
    super.key,
    required this.students,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return ListTile(
          title: Text('Studiante: ${student.name}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Primera nota: ${student.firstGrade}'),
              Text('Segunda nota:  ${student.secondGrade}'),
              Text('Nota final:  ${student.thirdGrade}'),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDelete(student.id),
          ),
          onTap: () => onUpdate(student),
        );
      },
    );
  }
}

class StudentDialog extends StatelessWidget {
  final String title;
  final Student? student;
  final void Function(Student) onSubmit;

  const StudentDialog({
    super.key,
    required this.title,
    this.student,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController(text: student?.name ?? '');
    final _firstGradeController =
        TextEditingController(text: student?.firstGrade.toString() ?? '');
    final _secondGradeController =
        TextEditingController(text: student?.secondGrade.toString() ?? '');
    final _thirdGradeController =
        TextEditingController(text: student?.thirdGrade.toString() ?? '');

    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          TextField(
            controller: _firstGradeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Primera Nota'),
          ),
          TextField(
            controller: _secondGradeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Segunda Nota'),
          ),
          TextField(
            controller: _thirdGradeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Tercera Nota'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final student = Student(
              id: this.student?.id ??
                  0, // ID será asignado por la base de datos
              name: _nameController.text,
              firstGrade: double.tryParse(_firstGradeController.text) ?? 0.0,
              secondGrade: double.tryParse(_secondGradeController.text) ?? 0.0,
              thirdGrade: double.tryParse(_thirdGradeController.text) ?? 0.0,
            );
            onSubmit(student);
          },
          child: Text(title),
        ),
      ],
    );
  }
}
