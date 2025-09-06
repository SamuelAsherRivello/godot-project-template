using Godot;

namespace RMC.MyProject.Templates
{
    //  Namespace Properties ------------------------------


    //  Class Attributes ----------------------------------


    /// <summary>
    /// Replace with comments...
    /// </summary>
    public class TemplateClass 
    {
        //  Events ----------------------------------------


        //  Properties ------------------------------------
        
        public string SamplePublicText { get { return _samplePublicText; } set { _samplePublicText = value; } }


        //  Fields ----------------------------------------
        [Export]
        private string _samplePublicText;


        //  Godot Methods ---------------------------------

        protected void _Ready()
        {
            GD.Print($"{GetType().Name}._Ready()");
        }


        protected void _Process(double delta)
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
