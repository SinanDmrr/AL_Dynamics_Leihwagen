// Die Page die diese Card aufruft muss die Verknüpfung erstellen -> CardPageId = KundenKarte; siehe in der Kundenliste.al
page 50102 KundenKarte
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = Kunde;
    Caption = 'Kunde';

    layout
    {
        area(Content)
        {
            group(General) // Nicht mehr repeater, weil hier ein Datensatz (der aktuell angeklickte oder zu erstellende) angezeigt wird und nicht die ganze Kunden table 
            {
                field("Kunden-Nr"; Rec."Kunden-Nr")
                {
                    Editable = false;
                }
                field("Name"; Rec.Name) { }
                field("Anschrift"; Rec.Anschrift) { }
                field("Beschreibung"; Rec.Beschreibung)
                {
                    // Ermöglicht eine Multiline beschreibung also nicht mehr in einer Zeile sondern eine Textbox über mehrere Zeilen
                    MultiLine = true;
                }
            }
        }
    }
}