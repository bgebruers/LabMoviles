
class Posteo {
  
  final String texto;
  final String valoracion;
  final String nombreUsuario;
  final String date;


  Posteo({
    required this.texto,
    required this.valoracion,
    required this.nombreUsuario,
  
    required this.date,
  });

  factory Posteo.fromMap(Map<String, dynamic> map) {
    return Posteo(
    
      texto: map['texto'] ?? '',
      valoracion: map['valoracion'] ?? '',
      nombreUsuario: map['nombreUsuario'] ?? '',
      date: map['date'] ?? '',
    );
  }
}