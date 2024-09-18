'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "3b58ae4181471e25173ebc9aab46f307",
"version.json": "c9b856a9c448f9420f16cbca17800325",
"index.html": "48902d1a398105aa4971d11afc53f263",
"/": "48902d1a398105aa4971d11afc53f263",
"main.dart.js": "e93534de3f9fa03d480dc772f4978cb7",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "153edfd504e3d3c3d6b2b2d8d95ce253",
"assets/images/original-5fd021ec87febc92d03e55429d8e381b.png": "9760c73ca0ea0009d09936fef044ed9a",
"assets/images/committee.jpg": "d9034cf44132c1b36ecd9dd29fa23f15",
"assets/images/apps5.jpeg": "70d86d89a8ce750cfe56b0837eed0feb",
"assets/images/earth.jpeg": "e5af3f9a1fa3bb1f18c18aaf27b674d8",
"assets/images/adu.jpg": "6a788725e1c02233e56a4e564fe87abc",
"assets/images/metal.png": "9a8029786f430470a0a3b3cb950bf4cc",
"assets/images/bawumia.jpg": "308c37bcedbfcf575942daae03179e36",
"assets/images/apps4.jpeg": "1411e7122d8381f2f443f100d03f1651",
"assets/images/earth2.jpeg": "e402dbc4897b838053b8f49f2f3692a4",
"assets/images/cpp.png": "7a7761d5feea93391d33dcb21c9e4261",
"assets/images/book3.jpg": "5e217b93a5592c546032d2b73b816466",
"assets/images/apps3.jpeg": "130bc347bc6055a331349140a96dc69d",
"assets/images/book2.jpg": "cf86c6e9794ce010e83975e5e5b0fb6c",
"assets/images/mete.png": "7fcc99a562813c732fb77cb3b2e99ca5",
"assets/images/others.png": "50dcae8836621084720e58bba93a04f9",
"assets/images/down.png": "f818ea6fc868807694a0ce6600ecb120",
"assets/images/book1.jpg": "64a3404ebdd0f02c67b1e0cc684ec365",
"assets/images/12.png": "0f27ee31fdfc788d9b68c6fad933b6e8",
"assets/images/book4.jpg": "1019c2680f6e315a29a2e24fad04cb7f",
"assets/images/atm.png": "0b276c10c920d5ec9bcb9ef23baa7a0a",
"assets/images/background.jpeg": "ee7f2b79d87698fa4b1f4a548b66e43c",
"assets/images/apps2.jpeg": "1dac845a94f9b1beb4842535442fd1c3",
"assets/images/search.png": "16b7c9ccf398322bddbfbd4083e5cb25",
"assets/images/original-18d8b499ae688550de708a0650077683.png": "158a3e014bb0a8b3e419a79d179c27de",
"assets/images/alex.jpg": "4f1d919347dc9013cc075400fa157987",
"assets/images/npp.png": "e12506284228b21ff52939b468ed7d32",
"assets/images/ndc.png": "c68ca05be14c65f827bc9790390a868a",
"assets/images/apps.jpeg": "aa6623ab9ab60bee4c23f2535feecb3d",
"assets/images/ylplogo.png": "5c2e6f0aa4d5437712f9527fce46fc68",
"assets/images/forson.jpg": "e4a032d774e00c3cafba8cf3e454703e",
"assets/images/2024-07-12-05-23-21-certificate.jpeg": "fd95da9923ec80b431eef99c9828869e",
"assets/images/amin.jpg": "2742db9504046266b1c7cc7c46425eb2",
"assets/images/foreign.jpg": "4c48194e0fc682bd80f6c3c16e17dceb",
"assets/images/nana.jpeg": "1cfc8fa80b7a1cf9380831f04571e543",
"assets/images/youth.jpeg": "bda0783877ee6fb5e5880538c683cda9",
"assets/images/original-18856d39a7a119f4883538013b709ce6.png": "99679ddbdbc51239c74a435f98b187af",
"assets/images/google.png": "d9fb1f9493f9436c75f24f6ed7a6aad5",
"assets/images/earth1.jpeg": "e2ec1e9512ee39ae36358f3e985ad87a",
"assets/images/apps6.jpeg": "48b830e1b3afcf20cd64f181148809d5",
"assets/images/ylpspeaker.jpg": "7f025470d712a6b33e0999ead5c77a12",
"assets/images/albrim.png": "532077a663435be1147fecbbb96bb6d4",
"assets/images/bagbin.jpg": "90c902a70e25531bf4aa2317fba060b7",
"assets/AssetManifest.json": "71f2e345c43c655cfbc0727e3f3d0514",
"assets/NOTICES": "542cf79a980c0d921d6c8f2daa6fa3d9",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "2cef6b2b7e3d084c7ba7a7deb5428541",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "391ff5f9f24097f4f6e4406690a06243",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "1d97cd8b719b489360e687b904efa2d0",
"assets/fonts/MaterialIcons-Regular.otf": "a9c057a22b861e66be4648347610d669",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
