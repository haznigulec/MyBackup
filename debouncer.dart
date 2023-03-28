//The Debouncer on this page helps to wait for the final version of the word written in the search boxes.
// In this way, we get rid of unnecessary requests to endpoints.
import 'dart:async';
import 'dart:ui';

class Debouncer {
  Duration delay;
  Timer? _timer;
  VoidCallback? _callback;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void debounce(VoidCallback callback) {
    _callback = callback;

    cancel();
    _timer = Timer(delay, flush);
  }

  void cancel() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void flush() {
    if (_callback != null) {
      _callback!();
      cancel();
    }
  }
}
-----------------------------------------------------------------------------------
...
  final Debouncer onSearchDebouncer = Debouncer(delay: const Duration(milliseconds: 500));
  ...

  onChanged: (value) {
                        onSearchDebouncer.debounce(() async {
                          sharedProducts.clear();
                          if (value.isEmpty) {
                            await SubProductRepo().getProducts(null);
                            setState(() {});
                            return;
                          }
                          await SubProductRepo().getProducts(value);
                          setState(() {});
                        });
                      },
