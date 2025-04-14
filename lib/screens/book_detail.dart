import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetail extends StatelessWidget {
  final Map book;

  const BookDetail({Key? key, required this.book}) : super(key: key);

  // Function to open URLs in the browser
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final volumeInfo = book['volumeInfo'];
    final thumbnail = volumeInfo['imageLinks'] != null
        ? volumeInfo['imageLinks']['thumbnail']
        : null;

    final previewLink = volumeInfo['previewLink'];
    final downloadLink = book['accessInfo']?['pdf']?['isAvailable'] == true
        ? book['accessInfo']?['pdf']?['acsTokenLink']
        : null;
    final buyLink = volumeInfo['infoLink'];

    return Scaffold(
      appBar: AppBar(
        title: Text(volumeInfo['title'] ?? 'No Title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Thumbnail
            thumbnail != null
                ? FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image: thumbnail,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/placeholder.png',
                  fit: BoxFit.cover,
                );
              },
            )
                : Image.asset(
              'assets/images/placeholder.png',
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 16),
            const Icon(
              Icons.book,
              size: 100,
            ),
            const SizedBox(height: 16),

            // Book Title
            Text(
              volumeInfo['title'] ?? 'No Title',
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Authors
            Text(
              'Author(s): ${volumeInfo['authors'] != null ? (volumeInfo['authors'] as List).join(', ') : 'Unknown'}',
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              volumeInfo['description'] ?? 'No Description',
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Preview Button
                if (previewLink != null)
                  ElevatedButton(
                    onPressed: () => _launchURL(previewLink),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                    ),
                    child: const Text(
                      'Preview',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(width: 10),

                // Download or More Info Button
                ElevatedButton(
                  onPressed: () =>
                      _launchURL(downloadLink ?? buyLink),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                  ),
                  child: Text(
                    downloadLink != null ? 'Download' : 'More Info',
                    style: const TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
