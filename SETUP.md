Xilinx käyttäjätunnuksen teko

    mene http://www.xilinx.com/

    tee uusi käyttäjätunnus jos ei jo ole -> Sign in

    oikealta alhaalta -> Create Account

    näiden tietojen täyttäminen omalla vastuulla, tässä haetaan selvästi työsähköpostia eikä harrastelijoita, mutta kaikki osoitteet on tainneet  kuitenkin kelvata

    sähköpostiin sitten kolahtaa varmistusmaili jonka linkkiä klikkaamalla tunnus alkaa toimia

    mennään uudestaan pääsivulle http://www.xilinx.com/

    kirjaudutaan tunnuksilla sisään -> Sign in

    menään osoitteeseen http://www.xilinx.com/getlicense -> tarkista tiedot -> Next

    -> Product Licensing -> Create New License -> Certificate Based Licenses

    -> [X] ISE WebPACK License -> Generate Node-Locked License -> ... -> Next

    "*, *, *, Node, *, nimi, päivä" tyylinen lisenssi tuntuu toimivan

    Manage Licenses sivun vasemmasta alalaidasta löytyy pieni nuoli alaspäin ikoni, sillä voi ladata lisenssitiedoston (Xilinx.lic) koneelle valmiiksi



Xilinx ISE WebPACK -kehitysympäristön asennus

    Vaikka ei ole virallisesti tuettujen listalla tämä on testattu toimivaksi ainakin Ubuntu 64-bit versioilla 14.10  ja 15.10

    oletetaan että on tehty tunnus http://www.xilinx.com/ -sivulle ja logattu sisään

    Downloads -> ISE Design Tools -> 14.7

    mutta ei haluta käyttää heidän typerää download manageria vaan suorat linkit tiedostoihin

    'If you wish to bypass the use of the Xilinx download manager, please see AR# 5784' -> http://www.xilinx.com/support/answers/57840.html

    -> ISE Design Suite - 14.7 Full Product Installation for Linux (TAR/GZIP - 6.09 GB)

    (tiedostot löytyy myös labin usbitikulta, eli ei tarvi ladata hitaalla netillä)

    tiedot -> Next -> aloittaa lataamisen

    tarkistetaan eheys: md5sum Xilinx_ISE_DS_Lin_14.7_1015_1.tar 

    e8065b2ffb411bb74ae32efa475f9817

    puretaan komennolla: tar -xvf Xilinx_ISE_DS_Lin_14.7_1015_1.tar

    vaatii tilaa 14 GB ja kestä hetken riippuen konesta

    siirrytään purettuun kansioon: cd Xilinx_ISE_DS_Lin_14.7_1015_1/

    ajetaan asennus: sudo ./xsetup

    -> Next -> [X] [X] -> Next -> [X] -> Next -> ISE WebPACK -> Next

    oletukset kelpaa, eli ei kaapeliajuria tässä -> [ ] [X] [x] [ ]

    ensimmäisen ruksin voi jättää myös pois jos on ladannut lisenssitiedoston jo koneelleen

    oletuskansio "/opt/Xilinx" kelpaa -> Next -> Install

    tämä sitten kestääkin, kahvitauko

    käynnistys:

    kopioi lisenssi valmiiksi paikoilleen käyttäjän kotihakemiston .Xilinx -kansioon, esim:

    mkdir ~/.Xilinx

    cp ~/Downloads/Xilinx.lic ~/.Xilinx/Xilinx.lic

    käynnistetään ISE

    source /opt/Xilinx/14.7/ISE_DS/settings64.sh && ise

    ensitöinään kannattaa asettaa Edit->Preferences...->ISE Text Editor->Tab width: 4

    Gno

    nano xilinx-ise.desktop

    me pohjaisille (Ubuntu jne) työpöydille voi tehdä .desktop tiedoston

    [Desktop Entry]

    Version=1.0

    Name=Xilinx ISE

    Type=Application

    Terminal=false

    Icon=/opt/Xilinx/14.7/ISE_DS/ISE/data/images/pn-ise.png

    Exec=bash -c "source /opt/Xilinx/14.7/ISE_DS/settings64.sh && ise"

    Categories=Utility;Application;Development;

    sudo desktop-file-install --delete-original xilinx-ise.desktop

    nyt se löytyy kuten muutkin ohjelmat kirjoittamalla esim. 'ISE' ubuntun 'käynnistimeen' ja tämän jälkeen sen voi liimata sivupalkkiin 'Lock to Launcher'

    jos et itse kopioinut lisenssiä paikalleen, pitäisi lisenssimanagerin nyt  kysellä lisenssiä:

     -> Ok -> Locate Excisting License(s) -> Next -> Load License...

    valitse aikaisemmin tallennettu Xilinx.lic -tiedosto -> Ok -> Close


    Platform Cable USB model DLC9G tai DLC9LP ohjelmointilaitteen asennus Ubuntuun

    kytke laatikko usb-johdolla kiinni koneeseen ja listaa usb-laitteet

    lsusb

    Bus 003 Device 006: ID 03fd:0007 Xilinx, Inc. (tai :000F DLC9LP:llä)

    ja status-ledi loistaa todella himmeänä punaisena

    irroita kaapeli ja tee seuraavat toimenpiteet

    sudo apt-get install libusb-dev fxload

    sudo nano /etc/udev/rules.d/xusbdfwu.rules

    lisää tiedostoon nämä kaksi riviä ja rivinvaihto, poistu ctrl-x ja y

    ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0008", MODE="666"

    SUBSYSTEMS=="usb", ACTION=="add", ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0007", RUN+="/sbin/fxload -v -t fx2 -I /usr/share/xusbdfwu.hex -D $tempnode"

    SUBSYSTEMS=="usb", ACTION=="add", ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="000f", RUN+="/sbin/fxload -v -t fx2 -I /usr/share/xusb_xlp.hex -D $tempnode"

    sudo cp /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/*.hex /usr/share/

    sudo /etc/init.d/udev restart

    vai olisiko "sudo udevadm control --reload-rules" parempi?

    kytke johto takaisin ja listaa usb-laitteet uudelleen

    lsusb

    Bus 003 Device 010: ID 03fd:0008 Xilinx, Inc.

    ja status-ledi palaa nyt kirkkaasti punaisena

    ja muuttuu vihreäksi jos kytket ohjelmoitilaitteen esim. CPLD-lautaan jossa virrat kiinni


Xilinx ISE WebPACK -kehitysympäristön asennus, Windows 7 (8.1 omalla vastuulla)

    (tiedostot löytyy myös labin usbitikulta, eli ei tarvi ladata hitaalla netillä)

    Lataa Windows ISE tästä linkistä (huom: paketti on yli 6 GB joten lataus kestää hieman. https://secure.xilinx.com/webreg/register.do?group=dlc&htmlfile=&emailFile=&cancellink=&eFrom=&eSubject=&version=14.7&akdm=0&filename=Xilinx_ISE_DS_Win_14.7_1015_1.tar

    Pura paketti johonkin sopivaan hakemistoon, vaikkapa Downloads tms. Tiedostoformaatti .tar on alunperin Unix-ympäristöstä peräisin, mutta ainakin ilmainen 7zip-ohjelma osaa purkaa sen. Tarvittaessa siis lataa ja asenna se.

    Asennus käynnistyy paketista purkautuneella xsetup.exe -ohjelmalla. Itse asennus Windowsissa on triviaali - vastaa kaikkin kysymyksin OK tms eli hyväksy kaikki oletusarvot. Joudut hyväksymään joitakin käyttöehtoja pariin kolmeen kertaan mutta sinäpä se. (asennus on liki identtinen kuin Ubuntulle tässä vaheessa).

    Muistaakseni asennus kysyy alkuvaiheessa, mikä editio asennetaan (Emdedded edition, DSP edition jne.). Tästä pitää valita Webpack, joka ei ole oletusarvo.

    Varsinainen asennus kestää h y v ä n   a i k a a ... joten keksi ajankulua. Loppupuolella asennus kysyy josko haluat asentaa Jungo-ajurin ja tähän vastaa myöntävästi jotta ohjelmointikaapeli toimisi myöhemmin.

    Kun asennus tulee valmiiksi, se huomauttaa että ennen varsinaisen ohjelman käyttöä pitää ajaa settings.bat -skripti. (Voi olla myös settings32 tai settings64 riippuen käyttisversiosta). Asennuksen päättymisen jälkeen siirry ohjelman asennushakemistoon  (oletusarvoisesti C:\Xilinx) esim File Explorerilla ja avaa komentoikkuna popup-valikosta jonka saat klikkaamalla hiiren oikeaa nappia Shift painettuna ("Open Command Window Here"). kirjoita kehoitteen perään skriptin nimi ja paina Enter. Valmis kun skripti lopettaa (melkein heti).

    ISE haluaa lisenssitiedoston samalla tavalla kuin yllä Ubuntulle asennettaessa. Lisenssin haku ja asennus tapahtuvat aivan samalla tavalla, tässä ei ole eroa käyttisten välillä. Windowsissa lisenssit talletetaan hakemistoon C:\.Xilinx (huomaa piste nimen edessä. Lisenssitiedoston voi kopioida sinne myös käsin ja homman pitäisi toimia normaalisti.

    Huom Windows 8.1 kanssa on ongelma lisenssimanagerin kanssa. Lisenssi manageri ilmoittaa: "_xlcm.exe lakkasi toimimasta". (W8 ei ole tuettujen käyttisten listalla) Mutta work-aroundeja on olemassa osoitteissa: https://www.youtube.com/watch?v=ttPbEcNjdo8 tai http://binarykoala.blogspot.fi/2013/10/get-xilinx-ise-146-webpack-to-work-on.html 

    Tämän jälkeen voi käynnistää Project Navigatorin normaalisti Start-valikosta.

    ensitöinään kannattaa asettaa Edit->Preferences...->ISE Text Editor->Tab width: 4

    Huomaa, että Windowsissa ei tarvita mitään erillistoimenpiteitä kaapeliajurin kanssa, se toimii suoraan pakasta vedettynä kuten yllä on kerrottu Ubuntun kohdalla. Ohjelmointilaitteen ledi siis palaa punaisena kun USB-yhteys toimii ja vihreänä kun ohjelmoitava piiri on havaittu toisessa päässä.



