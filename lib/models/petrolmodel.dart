class Petrol {
  final String name;
  final String distance;
  final String image;
  final int price;

  Petrol({this.name, this.distance, this.image, this.price});
}

List<Petrol> menu = [
  Petrol(
      name: "Nipco",
      distance: "0.4miles",
      image: "assets/nipco.jpg",
      price: 165),
  Petrol(
      name: "A.A Rano",
      distance: "0.5miles",
      image: "assets/aarano.png",
      price: 164),
  Petrol(
      name: "Mobil",
      distance: "0.8miles",
      image: "assets/mobil.png",
      price: 163),
  Petrol(
      name: "Oando",
      distance: "1.4miles",
      image: "assets/ngoandologo.png",
      price: 165),
];
