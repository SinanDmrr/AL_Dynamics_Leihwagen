page 50103 LeihwagenKarte
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = Leihwagen;
    Caption = 'Leihwagen';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Leihwagen-Nr"; Rec."Leihwagen-Nr") { }
                field(Marke; Rec.Marke) { }
                field(Modell; Rec.Modell) { }
                field("Kosten pro Tag"; Rec."Kosten pro Tag")
                {
                    Caption = 'Kosten pro Tag';
                    DecimalPlaces = 2;
                    MinValue = 0;
                }

                field(Status; Rec.Status)
                {
                    trigger OnValidate()
                    begin
                        if Rec.Status = Rec.Status::Frei then begin
                            Rec."Kunden-Nr" := 0;
                            Rec.Modify();
                        end;
                        CurrPage.Update();
                    end;
                }
                field("Kunden-Nr"; Rec."Kunden-Nr")
                {
                    ApplicationArea = All;
                    ToolTip = 'Kunde auswählen';
                    Editable = Rec.Status = Rec.Status::Vermietet;
                }
            }
        }
    }
}