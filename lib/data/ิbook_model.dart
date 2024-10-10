class Books {
  final String title;
  final String author;
  final String coverUrl;

  Books({
    required this.title,
    required this.author,
    required this.coverUrl,
  });

  factory Books.fromJson(Map<String, dynamic> json) {
    // Ensure that 'authors' is a list and safely access its elements
    var authorsList = json['authors'] as List<dynamic>?;

    return Books(
      title: json['title'] ?? 'No Title',
      author: (authorsList != null && authorsList.isNotEmpty)
          ? (authorsList[0]['name'] ?? 'Unknown Author')
          : 'Unknown Author',
      coverUrl: json['cover'] != null ? json['cover']['medium'] ?? '' : '',
    );
  }
}
class GoogleBook {
  final VolumeInfo? volumeInfo;

  GoogleBook({this.volumeInfo});

  factory GoogleBook.fromJson(Map<String, dynamic> json) {
    return GoogleBook(
      volumeInfo: json['volumeInfo'] != null
          ? VolumeInfo.fromJson(json['volumeInfo'])
          : null,
    );
  }
}

class VolumeInfo {
  final String? title;
  final List<String>? authors;
  final ImageLinks? imageLinks;

  VolumeInfo({this.title, this.authors, this.imageLinks});

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    return VolumeInfo(
      title: json['title'],
      authors: json['authors'] != null
          ? List<String>.from(json['authors'])
          : null,
      imageLinks: json['imageLinks'] != null
          ? ImageLinks.fromJson(json['imageLinks'])
          : null,
    );
  }
}

class ImageLinks {
  final String? thumbnail;

  ImageLinks({this.thumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return ImageLinks(
      thumbnail: json['thumbnail'],
    );
  }
}
