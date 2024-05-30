import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../controllers/servant_controller.dart';
import '../../models/servant.dart';

class ServantDetailScreen extends StatefulWidget {
  final int servantId;

  ServantDetailScreen({required this.servantId});

  @override
  _ServantDetailScreenState createState() => _ServantDetailScreenState();
}

class _ServantDetailScreenState extends State<ServantDetailScreen> {
  final ServantController _controller = ServantController();
  int _selectedAscension = 1;
  final double textSize = 16;
  final double titleSize = 19;
  late int servantIndex;

  @override
  void initState() {
    super.initState();
    _controller.fetchServantDetail(widget.servantId);
    servantIndex = _controller.getServantIndex(widget.servantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servant Detail',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          // IconButton(
          //   icon: Icon(
          //     ServantController.servants[servantIndex].isFavorite
          //         ? Icons.favorite
          //         : Icons.favorite_border,
          //     color: ServantController.servants[servantIndex].isFavorite
          //         ? Colors.red
          //         : null,
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       _controller.toggleFavorite(widget.servantId);
          //     });
          //   },
          // )

          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              ServantController.servants[servantIndex].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: ServantController.servants[servantIndex].isFavorite
                  ? Color.fromARGB(217, 228, 15, 0)
                  : null,
            ),
          ),
        ], // Ubah warna latar belakang appbar
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _controller.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return ValueListenableBuilder<ServantDetail?>(
            valueListenable: _controller.servantDetail,
            builder: (context, servantDetail, child) {
              if (servantDetail == null) {
                return Center(child: Text('Servant details not found'));
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          servantDetail
                              .ascensions[_selectedAscension.toString()]!,
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Wrap(
                          spacing: 8.0,
                          children: servantDetail.ascensions.keys.map((key) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedAscension = int.parse(key);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _selectedAscension.toString() == key
                                      ? Colors.blue
                                      : null,
                                  border: Border.all(
                                    color: _selectedAscension.toString() == key
                                        ? Colors.blue
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Image.network(
                                  servantDetail.ascensions[key]!,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 16),
                      Card(
                        color: Colors.blue[50],
                        child: ListTile(
                          title: Text(
                            servantDetail.name,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${servantDetail.className} • ${servantDetail.rarity}★',
                            style: TextStyle(fontSize: textSize),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildInfoSection('Gender', servantDetail.gender),
                      _buildInfoSection(
                          'Traits', servantDetail.traits.join(', ')),
                      _buildSkillsSection('Skills', servantDetail.skills),
                      _buildSkillsSection(
                          'Class Passive', servantDetail.classPassives),
                      _buildNoblePhantasmsSection(
                          'Noble Phantasms', servantDetail.noblePhantasms),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Card(
      color: Colors.blue[50],
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleSize),
        ),
        subtitle: Text(content, style: TextStyle(fontSize: textSize)),
      ),
    );
  }

  Widget _buildSkillsSection(String title, List<Skill> skills) {
    return Card(
      color: Colors.blue[50],
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleSize),
        ),
        children: skills.map((skill) {
          return ListTile(
            leading: Image.network(skill.icon),
            title: Text(skill.name, style: TextStyle(fontSize: textSize)),
            subtitle: Text(skill.detail, style: TextStyle(fontSize: textSize)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNoblePhantasmsSection(
      String title, List<NoblePhantasm> noblePhantasms) {
    return Card(
      color: Colors.blue[50],
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleSize),
        ),
        children: noblePhantasms.map((np) {
          return ListTile(
            leading: Image.network(np.icon),
            title: Text('${np.name} (${np.rank})',
                style: TextStyle(fontSize: textSize)),
            subtitle: Text('${np.type}\n${np.detail}',
                style: TextStyle(fontSize: textSize)),
          );
        }).toList(),
      ),
    );
  }
}
