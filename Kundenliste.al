page 50100 Kundenliste
{
    PageType = List;
    SourceTable = Kunde;
    ApplicationArea = All;
    Caption = 'Kunden';
    UsageCategory = Administration;
    CardPageId = KundenKarte;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Kunden-Nr"; Rec."Kunden-Nr")
                {
                    Editable = false;
                }
                field("Name"; Rec.Name) { }
                field("Anschrift"; Rec.Anschrift) { }
                field("Beschreibung"; Rec.Beschreibung) { }
            }
        }
    }
}
