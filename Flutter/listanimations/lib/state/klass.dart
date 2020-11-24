import 'package:listanimations/state/students.dart';

List<List<String>> names = [
  [
    "Erica Bright",
    "Marla Clarke",
    "Loretta Manning",
    "Marguerite Cook",
    "Little Raymond",
    "Love Mueller",
    "Carmela Lawrence",
    "Rhea Boyle"
  ],
  [
    "Lolita Gaines",
    "Camille Parks",
    "Cornelia Scott",
    "Sophie Hartman",
    "Dee Head",
    "Cote Mcclain",
    "Buckley Maynard",
    "Ashlee Bean",
    "Mara Carney",
    "Mariana Perez"
  ],
  [
    "Lawson Miles",
    "Adele Parker",
    "Marla Vargas",
    "Brock Jacobs",
    "Poole Michael",
    "Chapman Riddle",
    "Roxie Johnston"
  ],
  [
    "Ortiz Hardy",
    "Padilla Henderson",
    "Sheena Russo",
    "Cherry Lewis",
    "Clarissa Fowler",
    "Herminia Vincent",
    "Grant Long",
    "Zimmerman Stanley",
    "Jeannine Farmer"
  ],
  [
    "Wong Kidd",
    "Watkins Webb",
    "Lynette Sexton",
    "Rosales Eaton",
    "Sawyer Wells",
    "Larson Petersen",
    "Prince Alford",
    "Natalie Hunt",
    "Claudette Jimenez"
  ],
  [
    "Garrett Todd",
    "Hines Blanchard",
    "Black Fletcher",
    "Melinda Cole",
    "Caitlin Moody",
    "Elaine Pena",
    "Morrison Mcintosh",
    "Adrienne Townsend",
    "Hazel Leonard",
    "Atkins Perkins",
    "Beth Bishop",
    "Billie Melton",
  ]
];


class KlassState {
  int id;
  String name;
  List<StudentState> students;

  KlassState(this.id) {
    this.name = "Class #$id";
    this.students = names[this.id].map((name) => StudentState(id: this.id, name: name)).toList();
  }
}

