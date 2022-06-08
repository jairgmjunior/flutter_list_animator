import 'package:flutter/material.dart';
import 'package:listview_animado/model/usuario.model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<AnimatedListState> _listKey1 = GlobalKey();
  GlobalKey<AnimatedListState> _listKey2 = GlobalKey();

  List<UsuarioModel> usuarios = [
    UsuarioModel(
        nome: "João",
        url:
            'https://img.freepik.com/vetores-gratis/modelo-humano-sem-rosto-realista-3d_1441-2189.jpg?size=338&ext=jpg&ga=GA1.2.1265176562.1654687711'),
    UsuarioModel(
        nome: "José",
        url:
            'https://img.freepik.com/vetores-gratis/homem-misterioso-da-mafia-fumando-um-cigarro_52683-34828.jpg?size=338&ext=jpg&ga=GA1.2.1265176562.1654687711'),
    UsuarioModel(
        nome: "Marta",
        url:
            'https://img.freepik.com/psd-gratuitas/avatar-de-desenho-em-3d-isolado-em-renderizacao-3d_235528-260.jpg?size=338&ext=jpg&ga=GA1.2.1265176562.1654687711')
  ];

  List<UsuarioModel> lista1 = [];
  List<UsuarioModel> lista2 = [];

  @override
  void initState() {
    super.initState();

    lista2.addAll(usuarios);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              child: AnimatedList(
                key: _listKey1,
                initialItemCount: lista1.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index, animation) =>
                    _buildItemList1(index, lista1[index], animation),
              ),
            ),
            Expanded(
              child: AnimatedList(
                key: _listKey2,
                initialItemCount: lista2.length,
                shrinkWrap: true,
                itemBuilder: (context, index, animation) =>
                    _buildItemList2(index, lista2[index], animation),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemList1(
      int index, UsuarioModel usuario, Animation<double> animation) {
    return FadeTransition(
      key: UniqueKey(), //para não embaralhar as imagens
      opacity: animation,
      child: InkWell(
        onTap: () => _removeList1(index),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(usuario.url),
              ),
              Text(usuario.nome),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemList2(
      int index, UsuarioModel usuario, Animation<double> animation) {
    return FadeTransition(
      key: UniqueKey(), //para não embaralhar as imagens
      opacity: animation,
      child: ListTile(
        onTap: () => _removeList2(index),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(usuario.url),
        ),
        title: Text(usuario.nome),
      ),
    );
  }

  Duration duration = const Duration(milliseconds: 300);

  void _removeList2(int index) {
    var usuario = lista2[index];

    _listKey2.currentState!.removeItem(index,
        (context, animation) => _buildItemList2(index, usuario, animation),
        duration: duration);

    lista2.removeAt(index);
    lista1.add(usuario);

    _listKey1.currentState!.insertItem(lista1.length - 1, duration: duration);
  }

  void _removeList1(int index) {
    var usuario = lista1[index];

    _listKey1.currentState!.removeItem(index,
        (context, animation) => _buildItemList1(index, usuario, animation),
        duration: duration);

    lista1.removeAt(index);
    lista2.add(usuario);

    _listKey2.currentState!.insertItem(lista2.length - 1, duration: duration);
  }
}
