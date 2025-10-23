nearest-town / readme.txt / | LYVER |

=========================



ENGLISH

-------



Name

----

Nearest Town Waypoint (RedM / VORP client script)



Overview

--------

This client-only script finds the nearest predefined town to the player and

sets a GPS waypoint + single-point multi route to it. It also posts lightweight

chat and TipRight notifications. An event hook lets other resources trigger it.



Features

--------

\- Fast nearest-town lookup (2D distance: X/Y only)

\- Auto waypoint + single-point GPS Multi Route

\- Cleans route when you arrive (within 5m) or if the player sets a new waypoint

\- Simple notifications via VORP TipRight

\- Command + programmatic trigger (Net Event)



Requirements

------------

\- RedM (Cfx.re)

\- VORP Core (for `vorp:TipRight` notifications)



Files

-----

* client.lua
* fxmanifest.lua  
* readme.txt  (this file)



Installation

------------

1\) Place the resource folder (e.g. `nearest\_town`) in your server's `resources/`.

2\) Ensure it in your `server.cfg`:

&nbsp;  ensure nearest\_town

3\) Make sure VORP is running before this resource.



Usage

-----

\- Command: `/nearesttown`

&nbsp; Finds the closest town (from the `towns` table) and sets a waypoint to it.

&nbsp; If the closest is farther than 2000.0 meters, shows an info message instead.



\- Event trigger:

&nbsp; `TriggerEvent("nearest\_town:open")`

&nbsp; Programmatically runs the same logic as the command.



Configuration

-------------

\- Town list: edit the `towns` table at the top of `client.lua` (name + vector3).

\- Far distance threshold: change `2000.0` in the command handler.

\- Arrival radius: change `5.0` inside the thread that watches distance.

\- Notification system: replace `TriggerEvent("vorp:TipRight", text, 4000)` inside

&nbsp; `notifySimple` if you use a different notify resource.



Notes

-----

\- Distance is 2D (Z ignored). If you prefer 3D distance, it’s easy to switch.

\- Route is cleared when you are within 5m OR if the player manually sets a waypoint.



Troubleshooting

---------------

\- No notification? Ensure VORP is started and `vorp:TipRight` exists.

\- No waypoint? Make sure the native `SetNewWaypoint` is available on your build.

\- Nothing happens on command? Confirm the resource is ensured and no keybind

&nbsp; or command blocker conflicts. Check client F8 console for errors.



License

-------

Do whatever you want with it. Credit appreciated.





TÜRKÇE

------



Ad

--

En Yakın Kasaba Waypoint (RedM / VORP client script)



Özet

----

Bu yalnızca client tarafı script, oyuncuya en yakın tanımlı kasabayı bulur ve

o noktaya GPS waypoint + tek noktalı multi route çizer. Chat ve TipRight ile

hafif bildirimler verir. Diğer scriptlerin tetiklemesi için event de vardır.



Özellikler

----------

\- Hızlı en yakın kasaba bulma (2D mesafe: sadece X/Y)

\- Otomatik waypoint + tek noktalı GPS Multi Route

\- Hedefe varınca (5 m) veya oyuncu yeni waypoint kurarsa rotayı temizler

\- VORP TipRight ile basit bildirimler

\- Komut + programatik tetikleme (Net Event)



Gereksinimler

-------------

\- RedM (Cfx.re)

\- VORP Core (`vorp:TipRight` bildirimleri için)



Dosyalar

--------

* client.lua  
* fxmanifest.lua
* readme.txt  (bu dosya)



Kurulum

-------

1\) Kaynağı (örn. `nearest\_town`) sunucunuzun `resources/` klasörüne koyun.

2\) `server.cfg` içine ekleyin:

&nbsp;  ensure nearest\_town

3\) Bu kaynaktan önce VORP’un çalıştığından emin olun.



Kullanım

--------

\- Komut: `/nearesttown`

&nbsp; `towns` tablosundan en yakın kasabayı bulur ve oraya waypoint koyar.

&nbsp; En yakın mesafe 2000.0 metreden fazlaysa bilgi mesajı gösterir.



\- Event tetikleme:

&nbsp; `TriggerEvent("nearest\_town:open")`

&nbsp; Komutla aynı mantığı programatik olarak çalıştırır.



Ayarlar

------

\- Kasaba listesi: `client.lua` başındaki `towns` tablosunu düzenleyin (isim + vector3).

\- Uzaklık eşiği: komut içinde geçen `2000.0` değerini değiştirin.

\- Varış yarıçapı: mesafeyi izleyen thread içindeki `5.0` değerini değiştirin.

\- Bildirim sistemi: farklı bir notify kullanıyorsanız `notifySimple` içindeki

&nbsp; `TriggerEvent("vorp:TipRight", text, 4000)` satırını değiştirin.



Notlar

-----

\- Mesafe 2D hesaplanır (Z yok). 3D isterseniz kolayca çevrilebilir.

\- Hedefe 5 m kala veya oyuncu yeni waypoint kurarsa rota temizlenir.



Sorun Giderme

-------------

\- Bildirim yok mu? VORP’un çalıştığından ve `vorp:TipRight` eventinin mevcut

&nbsp; olduğundan emin olun.

\- Waypoint yok mu? `SetNewWaypoint` natifinin mevcut olduğundan emin olun.

\- Komut çalışmıyor mu? Kaynağın `ensure` edildiğini, başka bir komut veya

&nbsp; keybind ile çakışma olmadığını kontrol edin. F8 konsolunda hata var mı bakın.



Lisans

------

İstediğiniz gibi kullanın. Emek belirtirseniz seviniriz.



| LYVER |



