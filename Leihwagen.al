table 50101 Leihwagen
{
    Caption = 'Leihwagen';
    DataClassification = ToBeClassified; // Keine schützenswerten Daten

    fields
    {
        field(1; "Leihwagen-Nr"; Integer)
        {
            Caption = 'Leihwagen-Nr';
            Editable = false;
        }
        field(2; "Marke"; Text[50])
        {
            Caption = 'Marke';
        }
        field(3; "Modell"; Text[50])
        {
            Caption = 'Modell';
        }
        field(6; "Kosten pro Tag"; Decimal)
        {
            Caption = 'Kosten pro Tag';
            DecimalPlaces = 2;
            MinValue = 0;
        }
        field(4; "Status"; Option) // Option Datentyp initialisiert ein Dropdownmenü mit den OptionMembers
        {
            Caption = 'Status';
            OptionMembers = Frei,Vermietet;
        }
        field(5; "Kunden-Nr"; Integer)
        {
            Caption = 'Kunden-Nummer';
            DataClassification = CustomerContent;
            TableRelation = Kunde."Kunden-Nr"; // Verknüpft dieses Feld mit der "Kunden-Nr" aus der table Kunde
            // Lookup Verhalten von TableRelation sorgt automatisch dafür das ein Dropdownmenü erscheint mit den Kundennummern
            ValidateTableRelation = true; // Prüft ob der Kunde wirklich vorhanden ist
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Leihwagen-Nr")
        {
            Clustered = true;
        }
        key(ForeignKeyKunde; "Kunden-Nr") //Field 5 wird als ForeignKey genommen und die Tablenabhängikeit mit der table Kunde.Spalte Kunden-Nr gleich gesetzt
        {
        }
    }

    trigger OnInsert()
    var
        LeihwagenRec: Record Leihwagen;
        MaxNr: Integer;
    begin
        if LeihwagenRec.FindLast() then
            MaxNr := LeihwagenRec."Leihwagen-Nr"
        else
            MaxNr := 0;

        Rec."Leihwagen-Nr" := MaxNr + 1
    end;
}