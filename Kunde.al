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
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        KundeRec: Record Kunde;
        MaxNr: Integer;
    begin
        if Rec."Kunden-Nr" = 0 then begin
            if KundeRec.FindLast() then
                MaxNr := KundeRec."Kunden-Nr"
            else
                MaxNr := 0;

            Rec."Kunden-Nr" := MaxNr + 1;
        end;
    end;




    // SORGT FÜR FEHLER DER ERSTE WERT STARTET MIT KNr-100 
    // trigger OnInsert()
    // var
    //     KundeRec: Record Kunde;
    //     AktuelleNummer: Integer;
    //     MaxNummer: Integer;
    //     NummerText: Text;
    // begin
    //     if "Kunden-Nr" = '' then begin
    //         MaxNummer := 0;

    //         if KundeRec.FindSet() then begin
    //             repeat
    //                 if CopyStr(KundeRec."Kunden-Nr", 1, 4) = 'KNr-' then begin
    //                     NummerText := CopyStr(KundeRec."Kunden-Nr", 5);
    //                     if Evaluate(AktuelleNummer, NummerText) then begin
    //                         if AktuelleNummer > MaxNummer then
    //                             MaxNummer := AktuelleNummer;
    //                     end;
    //                 end;
    //             until KundeRec.Next() = 0;
    //         end;

    //         "Kunden-Nr" := 'KNr-' + PadStr(Format(MaxNummer + 1), 3, '0');
    //     end;
    // end;
}