//
//  Layout.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 10.04.17.
//
//

extension Layout: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 25
        let collectionCellSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionCellSize/2, height: collectionCellSize/2)
        
    }
    
}
