using Godot;

namespace RMC.MyProject
{
    //  Namespace Properties ------------------------------


    //  Class Attributes ----------------------------------

    /// <summary>
    /// Sample scene controller. Finds child "Cube" and moves it on X/Z
    /// using WASD and arrow keys. Y is unchanged.
    /// </summary>
    public partial class HUDCanvasLayer : CanvasLayer
    {
        //  Events ----------------------------------------


        //  Properties ------------------------------------


        //  Fields ----------------------------------------
        [Export]
        public CornerContainer CornerContainerUL;

        [Export]
        public CornerContainer CornerContainerUR;

        [Export]
        public CornerContainer CornerContainerLL;

        [Export]
        public CornerContainer CornerContainerLR;


        //  Godot Methods ---------------------------------

        public override void _Ready()
        {
            GD.Print($"{GetType().Name}.Start()");

            CornerContainerUL.RichTextLabel.Text = "UL";
            CornerContainerUR.RichTextLabel.Text = "UR";
            CornerContainerLL.RichTextLabel.Text = "LL";
            CornerContainerLR.RichTextLabel.Text = "LR";

        }

        public override void _Process(double delta)
        {

        }
        
        //  Methods ---------------------------------------

        //  Event Handlers --------------------------------
    }
}