import UIKit

class AlbumCell: UITableViewCell {

    let albumThumbnail   = UIObjects.image(cornerRadius: 15)
    let albumNameLabel   = UIObjects.label(fontWeigth: .bold, fontSize: 18)
    let albumArtistLabel = UIObjects.label(fontWeigth: .normal, fontSize: 12)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(albumThumbnail)
        containerView.addSubview(albumNameLabel)
        containerView.addSubview(albumArtistLabel)
        self.contentView.addSubview(containerView)

        albumThumbnail.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        albumThumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:10).isActive = true
        albumThumbnail.widthAnchor.constraint(equalToConstant:70).isActive = true
        albumThumbnail.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: albumThumbnail.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        albumNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        albumNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        albumNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        albumArtistLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor).isActive = true
        albumArtistLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        albumArtistLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    let containerView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true // this will make sure its children do not go out of the boundary
      return view
    }()

    
    
}


