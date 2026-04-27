import 'package:flutter/material.dart';
import 'package:todo_ai/model/todo.dart';

extension TodoExtension on Todo {
  bool get isOverdue {
    if (deadline == null) return false;
    return !isDone && deadline!.isBefore(DateTime.now());
  }

  Color? get backgroundColor {
    if (isDone) {
      return Colors.green[50];
    } else if (isOverdue) {
      return Colors.red[50];
    } else {
      return Colors.blue[50];
    }
  }

  Color? get highlightColor {
    if (isDone) {
      return Colors.green[200];
    } else if (isOverdue) {
      return Colors.red[200];
    } else {
      return Colors.blue[200];
    }
  }

  Color get textColor {
    if (isDone) {
      return Colors.green[800]!;
    } else if (isOverdue) {
      return Colors.red[800]!;
    } else {
      return Colors.blue[800]!;
    }
  }

  Color get iconColor {
    if (isDone) {
      return Colors.green;
    } else if (isOverdue) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  String? get detailText {
    if (isDone) {
      return 'Completed';
    } else if (isOverdue) {
      return 'Overdue';
    } else {
      return 'In Progress';
    }
  }

  IconData get detailIcon {
    if (isDone) {
      return Icons.check_circle;
    } else if (isOverdue) {
      return Icons.warning;
    } else {
      return Icons.pending;
    }
  }
}
