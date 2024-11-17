using System.ComponentModel.DataAnnotations;

namespace server.Dto
{
    public class ProductDto
    {
        [Required]
        [MaxLength(100)]
        public string Name { get; set; }

        [MaxLength(500)]
        public string Description { get; set; }

        [Required]
        public int Quantity { get; set; }

        [Required]
        public decimal Price { get; set; }

        // Foreign key to Category
        [Required]
        public int CategoryId { get; set; }

        // Foreign key to User
        [Required]
        public int UserId { get; set; }

        // Ajouter une propriété Image
        public string Image { get; set; }  // Ajouté ici
    }
}
