using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace server.Models
{
    public class ReviewModel
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Content { get; set; } // Le texte de l'avis

        [Required]
        [Range(1, 5)] // La note doit être entre 1 et 5
        public int Rating { get; set; }

        // Foreign key to Product
        [ForeignKey("Product")]
        public int ProductId { get; set; }

        // Foreign key to User
        [ForeignKey("User")]
        public int UserId { get; set; }

        // Navigation properties
        public virtual ProductModel Product { get; set; }
        public virtual UserModel User { get; set; }
    }
}
