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
            group(General)
            {
                field("Kunden-Nr"; Rec."Kunden-Nr")
                {
                    Editable = false;
                }
                field("Name"; Rec.Name) { }
                field("Anschrift"; Rec.Anschrift) { }
                field("Beschreibung"; Rec.Beschreibung)
                {
                    MultiLine = true;
                }
            }
        }
    }
}