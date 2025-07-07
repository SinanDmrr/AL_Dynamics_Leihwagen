page 50100 Kundenliste
{
    PageType = List; // Übersicht mit mehreren Einträgen ähnlich wie Excel Tabellen
    SourceTable = Kunde; // Verknüpfung zu Table 50100 Kunde
    ApplicationArea = All; // Ist von allen Anwendungsbereichen aus erreichbar
    Caption = 'Kunden'; // Überschrift
    UsageCategory = Administration; // Beim Suchen wird daneben Verwaltung angezeigt bei z.B. Lists steht da Listen hilft einfach zum kategorisieren
    CardPageId = KundenKarte; // Card Ansicht wenn man auf einen Kunden klickt oder einen neu anlegen will

    layout // Definiert wie die Page / Seite aufgebaut ist
    {
        area(content)   // Hauptinhalt ist hier drin
        {
            repeater(Group) // Ist eine Schleife die Zeile für Zeile alle Daten aus der 50100 Kunde table raus holt und anzeigt
            {
                // Die Werte aus der Schleife werden hier zugeordnet also aus dem aktuellen Schleifen durchgang Rec.Kunden-Nr wird unter der Spalte "Kunden-Nr" platziert
                // Angezeigt wird als Spaltenname "Kunden-Nummer", weil wir in der Table ja die Caption auf "Kunden-Nummer gesetzt haben"
                // ACHTUNG: Beachte hier die Reihenfolge ist auch die in der die Spalte auf der Page angezeigt werden -> 1. Kunden-Nr 2. Name 3. Anschrift usw.
                field("Kunden-Nr"; Rec."Kunden-Nr") { Editable = false; }
                field("Name"; Rec.Name) { Editable = false; }
                field("Anschrift"; Rec.Anschrift) { Editable = false; }
                field("Beschreibung"; Rec.Beschreibung) { Editable = false; }
            }
        }
    }
}
