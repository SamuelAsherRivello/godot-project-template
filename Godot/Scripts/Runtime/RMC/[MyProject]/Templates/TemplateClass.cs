using Godot;

namespace RMC.MyProject.Templates
{
    //  Namespace Properties ------------------------------


    //  Class Attributes ----------------------------------


    /// <summary>
    /// Replace with comments...
    /// </summary>
    public partial class TemplateClass : Node3D
    {
        //  Events ----------------------------------------


        //  Properties ------------------------------------
        
        public string SamplePublicText { get { return _samplePublicText; } set { _samplePublicText = value; } }


        //  Fields ----------------------------------------

        [Export]
        private string _samplePublicText;


        //  Godot Methods ---------------------------------

        /// <summary>
        /// Called when the node enters the scene tree for the first time.
        /// </summary>
        public override void _Ready()
        {
            GD.Print($"{GetType().Name}.Start()");
        }

        /// <summary>
        /// Called every frame. 'delta' is the elapsed time since the previous frame.
        /// </summary>
        /// <param name="delta"></param>
        public override void _Process(double delta)
        {

        }

        //  Methods ---------------------------------------

        public string SamplePublicMethod(string message)
        {
            return message;
        }


        //  Event Handlers --------------------------------

        public void Target_OnCompleted(string message)
        {

        }
    }
}
