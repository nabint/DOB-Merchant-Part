import 'dart:io';

class Product {
  final String description;
  final String title;
  final double price;
  final File image;
  final int days;
  final int hours;
  
  Product({this.price, this.description, this.title,this.image,this.days,this.hours});

}