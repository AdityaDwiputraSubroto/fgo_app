import 'package:fgo_app/views/fgo/servant_detail_screen.dart';
import 'package:flutter/material.dart';
import '../../models/servant.dart';
import '../../controllers/servant_controller.dart';

class ServantFavoritesScreen extends StatefulWidget {
  @override
  _ServantFavoritesScreenState createState() => _ServantFavoritesScreenState();
}

class _ServantFavoritesScreenState extends State<ServantFavoritesScreen> {
  final ServantController _servantController = ServantController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _servantController.fetchServants();
    _servantController.getFavoritedServants();
    //_servantController.addListener(_updateScreen);
    _searchController.addListener(_onSearchChanged);
  }

  // void _updateScreen() {
  //   setState(() {});
  // }

  void _onSearchChanged() {
    _servantController.searchFavorites(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servant Favorites',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _servantController.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<List<Servant>>(
                  valueListenable: _servantController.searchedServants,
                  builder: (context, servants, child) {
                    if (servants.isEmpty) {
                      return Center(child: Text('No servants found'));
                    }
                    return ListView.builder(
                      itemCount: servants.length,
                      itemBuilder: (context, index) {
                        final servant = servants[index];
                        return servantCard(servant);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget servantCard(servant) {
    return ListTile(
      leading: servant.face.isNotEmpty
          ? Image.network(servant.face)
          : Icon(Icons.image_not_supported),
      title: Text(servant.name),
      subtitle: Text(servant.className),
      trailing: IconButton(
        icon: Icon(
          servant.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: servant.isFavorite ? Colors.red : null,
        ),
        onPressed: () {
          setState(() {
            _servantController.toggleFavorite(servant.id);
            _servantController.deleteFavorite(servant.id);
          });
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServantDetailScreen(servantId: servant.id),
          ),
        );
      },
    );
  }
}
