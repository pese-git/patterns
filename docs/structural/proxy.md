# Заместитель


> **Также известен как:** Proxy


## Суть паттерна


**Заместитель** — это структурный паттерн проектирования, который позволяет подставлять вместо реальных объектов специальные объекты-заменители. Эти объекты перехватывают вызовы к оригинальному объекту, позволяя сделать что-то до или после передачи вызова оригиналу.

Паттерн Заместитель предлагает создать новый класс-дублёр, имеющий тот же интерфейс, что и оригинальный служебный объект. При получении запроса от клиента объект-заместитель сам бы создавал экземпляр служебного объекта и переадресовывал бы ему всю реальную работу.


Преимущества:


- Позволяет контролировать сервисный объект незаметно для клиента.
- Может работать, даже если сервисный объект ещё не создан.
- Может контролировать жизненный цикл служебного объекта.

Недостатки:

- Усложняет код программы из-за введения дополнительных классов.
- Увеличивает время отклика от сервиса.



Пример:

```dart
// Интерфейс удалённого сервиса.
abstract class ThridPartyYouTubeLib {
  List<dynamic> listVideos();
  dynamic getVideoInfo(id);
  void downloadVideo(id);
}

// Конкретная реализация сервиса. Методы этого класса
// запрашивают у YouTube различную информацию. Скорость запроса
// зависит не только от качества интернет-канала пользователя,
// но и от состояния самого YouTube. Значит, чем больше будет
// вызовов к сервису, тем менее отзывчивой станет программа.
class ThirdPartyYouTubeClass extends ThridPartyYouTubeLib {
  @override
  List<dynamic> listVideos() {
    // Получить список видеороликов с помощью API YouTube.
    print("Получить список видеороликов с помощью API YouTube.");
    return null;
  }

  @override
  dynamic getVideoInfo(id) {
    // Получить детальную информацию о каком-то видеоролике.
    print("Получить детальную информацию о каком-то видеоролике.");
    return null;
  }

  @override
  void downloadVideo(id) {
    // Скачать видео с YouTube.
    print("Скачать видео с YouTube.");
  }
}

// С другой стороны, можно кешировать запросы к YouTube и не
// повторять их какое-то время, пока кеш не устареет. Но внести
// этот код напрямую в сервисный класс нельзя, так как он
// находится в сторонней библиотеке. Поэтому мы поместим логику
// кеширования в отдельный класс-обёртку. Он будет делегировать
// запросы к сервисному объекту, только если нужно
// непосредственно выслать запрос.
class CachedYouTubeClass extends ThridPartyYouTubeLib {
  ThridPartyYouTubeLib _service;
  List<dynamic> _listCache;
  List<dynamic> _videoCache;

  CachedYouTubeClass(this._service);

  @override
  void downloadVideo(id) {
    bool needReset;
    if (!_downloadExists(id) || needReset) {
      _service.downloadVideo(id);
    }
  }

  @override
  dynamic getVideoInfo(id) {
    bool needReset = false;
    if (_videoCache == null || needReset) {
      _videoCache = _service.getVideoInfo(id);
    }
    return _videoCache;
  }

  @override
  List<dynamic> listVideos() {
    bool needReset = false;
    if (_listCache == null || needReset) {
      _listCache = _service.listVideos();
    }
    return _listCache;
  }

  bool _downloadExists(id) {
    return false;
  }
}

// Класс GUI, который использует сервисный объект. Вместо
// реального сервиса, мы подсунем ему объект-заместитель. Клиент
// ничего не заметит, так как заместитель имеет тот же
// интерфейс, что и сервис.
class YouTubeManager {
  ThridPartyYouTubeLib _service;

  YouTubeManager(this._service);

  void renderVideoPage(id) {
    final info = _service.getVideoInfo(id);
    // Отобразить страницу видеоролика.
  }

  void renderListPanel() {
    final list = _service.listVideos();
    // Отобразить список превьюшек видеороликов.
  }

  void reactOnUserInput(id) {
    renderVideoPage(id);
    renderListPanel();
  }
}

// Конфигурационная часть приложения создаёт и передаёт клиентам
// объект заместителя.
class Application {
  void init() {
    final YouTubeService = new ThirdPartyYouTubeClass();
    final YouTubeProxy = new CachedYouTubeClass(YouTubeService);
    final manager = new YouTubeManager(YouTubeProxy);
    manager.reactOnUserInput(0);
  }
}

void main(List<String> args) {
  final app = Application();
  app.init();
}
```