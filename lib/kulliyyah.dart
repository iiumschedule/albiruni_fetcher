final kulliyyahs = [
  Kulliyyah(code: 'KAHS', name: 'ALLIED HEALTH SCIENCES'),
  Kulliyyah(code: 'AED', name: 'ARCHITECTURE'),
  Kulliyyah(code: 'BRIDG', name: 'BRIDGING PROGRAMME'),
  Kulliyyah(code: 'CFL', name: 'CELPAD'),
  Kulliyyah(code: 'CCAC', name: 'COCU'),
  Kulliyyah(code: 'DENT', name: 'DENTISTRY'),
  Kulliyyah(code: 'EDUC', name: 'EDUCATION'),
  Kulliyyah(code: 'ENGIN', name: 'ENGIN'),
  Kulliyyah(code: 'ECONS', name: 'ENMS'),
  Kulliyyah(code: 'KICT', name: 'ICT'),
  Kulliyyah(
      code: 'IHART',
      name: 'INTERNATIONAL INSTITUTE FOR HALAL RESEARCH AND TRAINING'),
  Kulliyyah(code: 'IRKHS', name: 'IRKHS'),
  Kulliyyah(code: 'IIBF', name: 'ISLAMIC BANKING AND FINANCE'),
  Kulliyyah(code: 'ISTAC', name: 'ISTAC'),
  Kulliyyah(code: 'KLM', name: 'KLM'),
  Kulliyyah(code: 'LAWS', name: 'LAWS'),
  Kulliyyah(code: 'MEDIC', name: 'MEDICINE'),
  Kulliyyah(code: 'NURS', name: 'NURSING'),
  Kulliyyah(code: 'PHARM', name: 'PHARMACY'),
  Kulliyyah(code: 'KOS', name: 'SCIENCE'),
  Kulliyyah(
      code: 'SC4SH', name: 'SEJAHTERA CENTRE FOR SUSTAINABILTY AND HUMANITY'),
];

class Kulliyyah {
  final String code;
  final String name;

  Kulliyyah({required this.code, required this.name});

  @override
  String toString() {
    return '$code - $name';
  }
}
