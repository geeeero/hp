#!/usr/bin/perl

print "Content-type: text/html\n\n";

read(STDIN, $Daten, $ENV{'CONTENT_LENGTH'});
@Formularfelder = split(/&/, $Daten);
foreach $Feld (@Formularfelder) {
 ($nam, $value) = split(/=/, $Feld);
 $value =~ tr/+/ /;
 $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
 $value =~ s/<!--(.|\n)*-->//g;
 $value =~ s/<([^>]|\n)*>//g;
 $htmlvalue = $value;
 $htmlvalue =~ s/ä/\&auml\;/g;
 $htmlvalue =~ s/ö/\&ouml\;/g;
 $htmlvalue =~ s/ü/\&uuml\;/g;
 $htmlvalue =~ s/Ä/\&Auml\;/g;
 $htmlvalue =~ s/Ö/\&Ouml\;/g;
 $htmlvalue =~ s/Ü/\&Uuml\;/g;
 $htmlvalue =~ s/ß/\&szlig\;/g;
 $htmlvalue =~ s/\"/\&quot\;/g;
 if ($nam eq "name") {$name=$value; $htmlname=$htmlvalue;}
 if ($nam eq "vorname") {$vorname=$value; $htmlvorname=$htmlvalue;}
 if ($nam =~ "matrikelnummer") {$matrikelnummer=$value;}
 if ($nam =~ "pruefungsordnung") {$pruefungsordnung=$value; $htmlpruefungsordnung=$htmlvalue;}
 if ($nam =~ "hauptfach") {$hauptfach=$value; $htmlhauptfach=$htmlvalue;}
 if ($nam =~ "anderePO") {$anderePO=$value; $htmlanderePO=$htmlvalue;}
 if ($nam =~ "email") {$email=$value;}
}

$name=lc($name);
$name=ucfirst($name);

$vorname=lc($vorname);
$vorname=ucfirst($vorname);

if ($pruefungsordnung =~ "Statistik als NF von BA- und MA-Studiengaengen 2007") {$htmlhauptfach = "mit Hauptfach ".$htmlhauptfach}
if ($pruefungsordnung =~ "Andere") {$htmlanderePO = " Pr&uuml;fungsordnung: ".$htmlanderePO}

open(file, ">>../ergebnisse/klausuranmeldung_vorlesungXY-v4.txt");
flock(file,2);
print file qq($email;$matrikelnummer;$name;$vorname;$pruefungsordnung;$hauptfach$anderePO\n);
flock(file,8);
close(file);

print qq(

<html>
<head>
<title>Klausuranmeldung am Institut f&uuml;r Statistik</title>
</head>
<body>

<h1>Klausuranmeldung VORLESUNG XY</h1>

Sie haben sich mit folgenden Daten angemeldet:<br><br>
<table>
<tr><td>Nachname:</td><td>$htmlname</td></tr>
<tr><td>Vorname:</td><td>$htmlvorname</td></tr>
<tr><td>Matrikelnummer:</td><td>$matrikelnummer</td></tr>
<tr><td>Pr&uuml;fungsordnung:</td><td>$htmlpruefungsordnung $htmlhauptfach $htmlanderePO</td></tr>
<tr><td>E-Mail:</td><td>$email</td></tr>
</table>
<br>
<br>
<br>
In K&uuml;rze erhalten Sie eine Best&auml;tigungsmail an die angegebene Adresse.
<br>
<br>
Haben Sie einen Fehler bei der Angabe Ihrer Daten gemacht, so melden Sie sich bitte noch einmal an ("Zur&uuml;ck"-Funktion des Browsers).
<br>
<br>
Zur&uuml;ck zur Homepage <a href="http://www.statistik.lmu.de/pfad/zur/vorlesungXY.html">VORLESUNG XY</a>.
);


open(mail,"|/usr/lib/sendmail -t");
print mail "From: PERSON.XY\@stat.uni-muenchen.de (Klausuranmeldung)\n";
print mail "To: $email\n";
print mail "Reply-to: PERSON.XY\@stat.uni-muenchen.de\n";
print mail "Subject: Klausuranmeldung VORLESUNG XY\n\n";
print mail "Sie haben sich erfolgreich zur Klausur VORLESUNG XY am DATUM TT.MM.JJJJ angemeldet.";
close(mail);
