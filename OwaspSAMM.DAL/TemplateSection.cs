//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace OwaspSAMM.DAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class TemplateSection
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public TemplateSection()
        {
            this.TemplateGroups = new HashSet<TemplateGroup>();
        }
    
        public int SecID { get; set; }
        public int SectionID { get; set; }
        public int SectionOrder { get; set; }
        public int CategoryID { get; set; }
    
        public virtual Section Section { get; set; }
        public virtual TemplateCategory TemplateCategory { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TemplateGroup> TemplateGroups { get; set; }
    }
}
