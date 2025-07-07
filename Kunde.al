// Tabellenname in Einzahl und Groß
table 50100 Kunde
{
    Caption = 'Kunden'; // Caption in Mehrzahl
    // Wird für DSGVO & Datenschutz verwendet. Gibt an wie sensibel ein Feld oder Tabelle ist
    DataClassification = CustomerContent; // Personenbezogene Daten
    // Felder der Tabelle
    fields
    {
        // Einzelne Felder innerhalb Fields angeben
        field(1; "Kunden-Nr"; Integer) //"Kunden-Nr ist die verknüpfung des Fields und nicht die Beschreibung"
        {
            Caption = 'Kunden-Nummer';  // Das ist die Beschreibung der Tabelle
            Editable = false;
        }
        field(2; "Name"; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Anschrift"; Text[250])
        {
            Caption = 'Anschrift';
        }
        field(4; "Beschreibung"; Text[1000])
        {
            Caption = 'Beschreibung';
        }
    }

    keys
    {
        key(PK; "Kunden-Nr")
        {
            //heißt, dass die Daten physisch auf der Festplatte in der Reihenfolge dieses Schlüssels gespeichert werden (Clustern).
            // Das verbessert die Performance bei Abfragen nach diesem Schlüssel.
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        KundeRec: Record Kunde; // Gesamte Tabelle die hinterlegt ist
        MaxNr: Integer;
    begin
        if KundeRec.FindLast() then
            MaxNr := KundeRec."Kunden-Nr"
        else
            MaxNr := 0;

        Rec."Kunden-Nr" := MaxNr + 1;   // Rec."Kunden-Nr" -> Aktueller Datensatz der den trigger ausgelöst hat. -> Automatische erhöhung des PK beim neu anlegen eines Kundens
    end;
}