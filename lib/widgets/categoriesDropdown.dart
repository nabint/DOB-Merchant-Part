class Categories {
  int id;
  String name;
 
  Categories(this.id, this.name);
 
  static List<Categories> getCompanies() {
    return <Categories>[
      Categories(1, 'Computer Store'),
      Categories(2, 'Department Store'),
      Categories(3, 'Gift Shops'),
      Categories(4, 'Stationary'),
      Categories(5, 'Futsal'),
    ];
  }
}