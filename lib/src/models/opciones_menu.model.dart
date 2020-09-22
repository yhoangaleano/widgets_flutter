import 'dart:convert';

OpcionesMenuModel opcionesMenuModelFromJson(String str) => OpcionesMenuModel.fromJson(json.decode(str));

String opcionesMenuModelToJson(OpcionesMenuModel data) => json.encode(data.toJson());

class OpcionesMenuModel {
    OpcionesMenuModel({
        this.ruta,
        this.icon,
        this.texto,
    });

    String ruta;
    String icon;
    String texto;

    factory OpcionesMenuModel.fromJson(Map<String, dynamic> json) => OpcionesMenuModel(
        ruta: json["ruta"],
        icon: json["icon"],
        texto: json["texto"],
    );

    Map<String, dynamic> toJson() => {
        "ruta": ruta,
        "icon": icon,
        "texto": texto,
    };
}
