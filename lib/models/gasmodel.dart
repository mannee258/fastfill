class Gas {
  final String gname;
  final String gdistance;
  final String gimage;
  final int gprice;

  Gas({this.gname, this.gdistance, this.gimage, this.gprice});
}

List<Gas> menus = [
  Gas(
    gname: "Leksherde Gas",
    gdistance: "3miles",
    gimage: "assets/aarano.png",
    gprice: 5000,
  ),
  Gas(
    gname: "Nipco Gas",
    gdistance: "4.5miles",
    gimage: "assets/nipco.jpg",
    gprice: 4500,
  ),
  Gas(
      gname: "Shell Gas",
      gdistance: "4miles",
      gimage: "assets/shell.png",
      gprice: 4300),
  Gas(
      gname: "NNPC Gas",
      gdistance: "4.1miles",
      gimage: "assets/nnpc.jpg",
      gprice: 4700),
  Gas(
      gname: "Total Gas",
      gdistance: "2.4miles",
      gimage: "assets/shell.png",
      gprice: 5000)
];
