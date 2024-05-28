// views/servant_list_view.dart
import 'package:fgo_app/views/servant_detail_screen.dart';
import 'package:flutter/material.dart';
import '../models/servant.dart';
import '../controllers/servant_controller.dart';

class ServantListScreen extends StatefulWidget {
  @override
  _ServantListScreenState createState() => _ServantListScreenState();
}

class _ServantListScreenState extends State<ServantListScreen> {
  final ServantController _servantController = ServantController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _servantController.fetchServants();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _servantController.searchServants(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Servant List', style: TextStyle(fontWeight: FontWeight.bold)),
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
